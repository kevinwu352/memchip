import 'dart:convert';
import 'dart:typed_data';

/// A bitmask that limits an integer to 32 bits.
const _mask32 = 0xFFFFFFFF;

/// The number of bits in a byte.
const _bitsPerByte = 8;

/// The number of bytes in a 32-bit word.
const _bytesPerWord = 4;

/// Adds [x] and [y] with 32-bit overflow semantics.
int _add32(int x, int y) => (x + y) & _mask32;

/// Bitwise rotates [val] to the left by [shift], obeying 32-bit overflow
/// semantics.
int _rotl32(int val, int shift) {
  var modShift = shift & 31;
  return ((val << modShift) & _mask32) | ((val & _mask32) >> (32 - modShift));
}

/// A message digest as computed by a `Hash` or `HMAC` function.
class _Digest {
  /// The message digest as an array of bytes.
  final List<int> bytes;

  _Digest(this.bytes);

  /// Returns whether this is equal to another digest.
  ///
  /// This should be used instead of manual comparisons to avoid leaking
  /// information via timing.
  @override
  bool operator ==(Object other) {
    if (other is _Digest) {
      final a = bytes;
      final b = other.bytes;
      final n = a.length;
      if (n != b.length) {
        return false;
      }
      var mismatch = 0;
      for (var i = 0; i < n; i++) {
        mismatch |= a[i] ^ b[i];
      }
      return mismatch == 0;
    }
    return false;
  }

  @override
  int get hashCode => Object.hashAll(bytes);

  /// The message digest as a string of hexadecimal digits.
  @override
  String toString() => _hexEncode(bytes);
}

String _hexEncode(List<int> bytes) {
  const hexDigits = '0123456789abcdef';
  var charCodes = Uint8List(bytes.length * 2);
  for (var i = 0, j = 0; i < bytes.length; i++) {
    var byte = bytes[i];
    charCodes[j++] = hexDigits.codeUnitAt((byte >> 4) & 0xF);
    charCodes[j++] = hexDigits.codeUnitAt(byte & 0xF);
  }
  return String.fromCharCodes(charCodes);
}

/// A sink used to get a digest value out of `Hash.startChunkedConversion`.
class _DigestSink implements Sink<_Digest> {
  /// The value added to the sink.
  ///
  /// A value must have been added using [add] before reading the `value`.
  _Digest get value => _value!;

  _Digest? _value;

  /// Adds [value] to the sink.
  ///
  /// Unlike most sinks, this may only be called once.
  @override
  void add(_Digest value) {
    if (_value != null) throw StateError('add may only be called once.');
    _value = value;
  }

  @override
  void close() {
    if (_value == null) throw StateError('add must be called once.');
  }
}

/// An interface for cryptographic hash functions.
///
/// Every hash is a converter that takes a list of ints and returns a single
/// digest. When used in chunked mode, it will only ever add one digest to the
/// inner [Sink].
abstract class _Hash extends Converter<List<int>, _Digest> {
  /// The internal block size of the hash in bytes.
  ///
  /// This is exposed for use by the `Hmac` class,
  /// which needs to know the block size for the [Hash] it uses.
  int get blockSize;

  const _Hash();

  @override
  _Digest convert(List<int> input) {
    var innerSink = _DigestSink();
    var outerSink = startChunkedConversion(innerSink);
    outerSink.add(input);
    outerSink.close();
    return innerSink.value;
  }

  @override
  ByteConversionSink startChunkedConversion(Sink<_Digest> sink);
}

/// A base class for [Sink] implementations for hash algorithms.
///
/// Subclasses should override [updateHash] and [digest].
abstract class _HashSink implements Sink<List<int>> {
  /// The inner sink that this should forward to.
  final Sink<_Digest> _sink;

  /// Whether the hash function operates on big-endian words.
  final Endian _endian;

  /// A [ByteData] view of the current chunk of data.
  ///
  /// This is an instance variable to avoid re-allocating.
  ByteData? _byteDataView;

  /// The actual chunk of bytes currently accumulating.
  ///
  /// The same allocation will be reused over and over again; once full it is
  /// passed to the underlying hashing algorithm for processing.
  final Uint8List _chunk;

  /// The index of the next insertion into the chunk.
  int _chunkNextIndex;

  /// A [Uint32List] (in specified endian) copy of the chunk.
  ///
  /// This is an instance variable to avoid re-allocating.
  final Uint32List _chunk32;

  /// Messages with more than 2^53-1 bits are not supported.
  ///
  /// This is the largest value that is precisely representable
  /// on both JS and the Dart VM.
  /// So the maximum length in bytes is (2^53-1)/8.
  static const _maxMessageLengthInBytes = 0x0003ffffffffffff;

  /// The length of the input data so far, in bytes.
  int _lengthInBytes = 0;

  /// Whether [close] has been called.
  bool _isClosed = false;

  /// The words in the current digest.
  ///
  /// This should be updated each time [updateHash] is called.
  Uint32List get digest;

  /// The number of signature bytes emitted at the end of the message.
  ///
  /// An encrypted message is followed by a signature which depends
  /// on the encryption algorithm used. This value specifies the
  /// number of bytes used by this signature. It must always be
  /// a power of 2 and no less than 8.
  final int _signatureBytes;

  /// Creates a new hash.
  ///
  /// [chunkSizeInWords] represents the size of the input chunks processed by
  /// the algorithm, in terms of 32-bit words.
  _HashSink(this._sink, int chunkSizeInWords, {Endian endian = Endian.big, int signatureBytes = 8})
    : _endian = endian,
      assert(signatureBytes >= 8),
      _signatureBytes = signatureBytes,
      _chunk = Uint8List(chunkSizeInWords * _bytesPerWord),
      _chunkNextIndex = 0,
      _chunk32 = Uint32List(chunkSizeInWords);

  /// Runs a single iteration of the hash computation, updating [digest] with
  /// the result.
  ///
  /// [chunk] is the current chunk, whose size is given by the
  /// `chunkSizeInWords` parameter passed to the constructor.
  void updateHash(Uint32List chunk);

  @override
  void add(List<int> data) {
    if (_isClosed) throw StateError('Hash.add() called after close().');
    _lengthInBytes += data.length;
    _addData(data);
  }

  void _addData(List<int> data) {
    var dataIndex = 0;
    var chunkNextIndex = _chunkNextIndex;
    final size = _chunk.length;
    _byteDataView ??= _chunk.buffer.asByteData();
    while (true) {
      // Check if there is enough data left in [data] for a full chunk.
      var restEnd = chunkNextIndex + data.length - dataIndex;
      if (restEnd < size) {
        // There is not enough data, so just add into [_chunk].
        _chunk.setRange(chunkNextIndex, restEnd, data, dataIndex);
        _chunkNextIndex = restEnd;
        return;
      }

      // There is enough data to fill the chunk. Fill it and process it.
      _chunk.setRange(chunkNextIndex, size, data, dataIndex);
      dataIndex += size - chunkNextIndex;

      // Now do endian conversion to words.
      var j = 0;
      do {
        _chunk32[j] = _byteDataView!.getUint32(j * _bytesPerWord, _endian);
        j++;
      } while (j < _chunk32.length);

      updateHash(_chunk32);
      chunkNextIndex = 0;
    }
  }

  @override
  void close() {
    if (_isClosed) return;
    _isClosed = true;

    _finalizeAndProcessData();
    assert(_chunkNextIndex == 0);
    _sink.add(_Digest(_byteDigest()));
    _sink.close();
  }

  Uint8List _byteDigest() {
    if (_endian == Endian.host) return digest.buffer.asUint8List();

    // Cache the digest locally as `get` could be expensive.
    final cachedDigest = digest;
    final byteDigest = Uint8List(cachedDigest.lengthInBytes);
    final byteData = byteDigest.buffer.asByteData();
    for (var i = 0; i < cachedDigest.length; i++) {
      byteData.setUint32(i * _bytesPerWord, cachedDigest[i]);
    }
    return byteDigest;
  }

  /// Finalizes the data and finishes the hash.
  ///
  /// This adds a 1 bit to the end of the message, and expands it with 0 bits to
  /// pad it out.
  void _finalizeAndProcessData() {
    if (_lengthInBytes > _maxMessageLengthInBytes) {
      throw UnsupportedError('Hashing is unsupported for messages with more than 2^53 bits.');
    }

    final contentsLength = _lengthInBytes + 1 /* 0x80 */ + _signatureBytes;
    final finalizedLength = _roundUp(contentsLength, _chunk.lengthInBytes);

    // Prepare the finalization data.
    var padding = Uint8List(finalizedLength - _lengthInBytes);
    // Pad out the data with 0x80, eight or sixteen 0s, and as many more 0s
    // as we need to land cleanly on a chunk boundary.
    padding[0] = 0x80;

    // The rest is already 0-bytes.

    var lengthInBits = _lengthInBytes * _bitsPerByte;

    // Add the full length of the input data as a 64-bit value at the end of the
    // hash. Note: we're only writing out 64 bits, so skip ahead 8 if the
    // signature is 128-bit.
    final offset = padding.length - 8;
    var byteData = padding.buffer.asByteData();

    // We're essentially doing byteData.setUint64(offset, lengthInBits, _endian)
    // here, but that method isn't supported on dart2js so we implement it
    // manually instead.
    var highBits = lengthInBits ~/ 0x100000000; // >> 32
    var lowBits = lengthInBits & _mask32;
    if (_endian == Endian.big) {
      byteData.setUint32(offset, highBits, _endian);
      byteData.setUint32(offset + _bytesPerWord, lowBits, _endian);
    } else {
      byteData.setUint32(offset, lowBits, _endian);
      byteData.setUint32(offset + _bytesPerWord, highBits, _endian);
    }

    _addData(padding);
  }

  /// Rounds [val] up to the next multiple of [n], as long as [n] is a power of
  /// two.
  int _roundUp(int val, int n) => (val + n - 1) & -n;
}

/// Data from a non-linear mathematical function that functions as
/// reproducible noise.
const _noise = [
  0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee, 0xf57c0faf, 0x4787c62a, //
  0xa8304613, 0xfd469501, 0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
  0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821, 0xf61e2562, 0xc040b340,
  0x265e5a51, 0xe9b6c7aa, 0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
  0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed, 0xa9e3e905, 0xfcefa3f8,
  0x676f02d9, 0x8d2a4c8a, 0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
  0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70, 0x289b7ec6, 0xeaa127fa,
  0xd4ef3085, 0x04881d05, 0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
  0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039, 0x655b59c3, 0x8f0ccc92,
  0xffeff47d, 0x85845dd1, 0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
  0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391,
];

/// Per-round shift amounts.
const _shiftAmounts = [
  07, 12, 17, 22, 07, 12, 17, 22, 07, 12, 17, 22, 07, 12, 17, 22, 05, 09, 14, //
  20, 05, 09, 14, 20, 05, 09, 14, 20, 05, 09, 14, 20, 04, 11, 16, 23, 04, 11,
  16, 23, 04, 11, 16, 23, 04, 11, 16, 23, 06, 10, 15, 21, 06, 10, 15, 21, 06,
  10, 15, 21, 06, 10, 15, 21,
];

/// The concrete implementation of `MD5`.
///
/// This is separate so that it can extend [HashSink] without leaking additional
/// public members.
class _MD5Sink extends _HashSink {
  @override
  final digest = Uint32List(4);

  _MD5Sink(Sink<_Digest> sink) : super(sink, 16, endian: Endian.little) {
    digest[0] = 0x67452301;
    digest[1] = 0xefcdab89;
    digest[2] = 0x98badcfe;
    digest[3] = 0x10325476;
  }

  @override
  void updateHash(Uint32List chunk) {
    // This makes the VM get rid of some "GenericCheckBound" calls.
    // See also https://github.com/dart-lang/sdk/issues/60753.
    // ignore: unnecessary_statements
    chunk[15];

    // Access [3] first to get rid of some "GenericCheckBound" calls.
    var d = digest[3];
    var c = digest[2];
    var b = digest[1];
    var a = digest[0];

    var e = 0;
    var f = 0;

    @pragma('vm:prefer-inline')
    void round(int i) {
      var temp = d;
      d = c;
      c = b;

      b = _add32(b, _rotl32(_add32(_add32(a, e), _add32(_noise[i], chunk[f])), _shiftAmounts[i]));

      a = temp;
    }

    for (var i = 0; i < 16; i++) {
      e = (b & c) | ((~b & _mask32) & d);
      // Doing `i % 16` would get rid of a "GenericCheckBound" call in the VM,
      // but is slightly slower anyway.
      // See also https://github.com/dart-lang/sdk/issues/60753.
      f = i;
      round(i);
    }

    for (var i = 16; i < 32; i++) {
      e = (d & b) | ((~d & _mask32) & c);
      f = ((5 * i) + 1) % 16;
      round(i);
    }

    for (var i = 32; i < 48; i++) {
      e = b ^ c ^ d;
      f = ((3 * i) + 5) % 16;
      round(i);
    }

    for (var i = 48; i < 64; i++) {
      e = c ^ (b | (~d & _mask32));
      f = (7 * i) % 16;
      round(i);
    }

    digest[0] = _add32(a, digest[0]);
    digest[1] = _add32(b, digest[1]);
    digest[2] = _add32(c, digest[2]);
    digest[3] = _add32(d, digest[3]);
  }
}

/// An implementation of the [MD5][rfc] hash function.
///
/// [rfc]: https://tools.ietf.org/html/rfc1321
///
/// **Warning**: MD5 has known collisions and should only be used when required
/// for backwards compatibility.
///
/// Use the [md5] object to perform MD5 hashing.
class _MD5 extends _Hash {
  @override
  final int blockSize = 16 * _bytesPerWord;

  const _MD5._();

  @override
  ByteConversionSink startChunkedConversion(Sink<_Digest> sink) => ByteConversionSink.from(_MD5Sink(sink));
}

/// An implementation of the [MD5][rfc] hash function.
///
/// [rfc]: https://tools.ietf.org/html/rfc1321
///
/// **Warning**: MD5 has known collisions and should only be used when required
/// for backwards compatibility.
const _Hash _md5 = _MD5._();

extension StringMd5Ext on String {
  String get md5 => _md5.convert(utf8.encode(this)).toString();
}
