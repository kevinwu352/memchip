import 'dart:convert';
import 'dart:typed_data';

const int _mask_5 = 0x1F;
const int _mask_32 = 0xFFFFFFFF;

final List<int> _mask32_hi_bits = [
  0xFFFFFFFF, 0x7FFFFFFF, 0x3FFFFFFF, 0x1FFFFFFF, 0x0FFFFFFF, //
  0x07FFFFFF, 0x03FFFFFF, 0x01FFFFFF, 0x00FFFFFF, 0x007FFFFF,
  0x003FFFFF, 0x001FFFFF, 0x000FFFFF, 0x0007FFFF, 0x0003FFFF,
  0x0001FFFF, 0x0000FFFF, 0x00007FFF, 0x00003FFF, 0x00001FFF,
  0x00000FFF, 0x000007FF, 0x000003FF, 0x000001FF, 0x000000FF,
  0x0000007F, 0x0000003F, 0x0000001F, 0x0000000F, 0x00000007,
  0x00000003, 0x00000001, 0x00000000,
];

List<int> _n = [
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

List<int> _sa = <int>[
  07, 12, 17, 22, 07, 12, 17, 22, 07, 12, 17, 22, 07, 12, 17, 22, 05, 09, 14, //
  20, 05, 09, 14, 20, 05, 09, 14, 20, 05, 09, 14, 20, 04, 11, 16, 23, 04, 11,
  16, 23, 04, 11, 16, 23, 04, 11, 16, 23, 06, 10, 15, 21, 06, 10, 15, 21, 06,
  10, 15, 21, 06, 10, 15, 21,
];

List<int> _join32(List<int> msg, int start, int end, Endian endian) {
  var len = end - start;
  assert(len % 4 == 0);
  var res = List.filled((len ~/ 4), 0);
  for (var i = 0, k = start; i < res.length; i++, k += 4) {
    int w;
    if (endian == Endian.big) {
      w = (msg[k] << 24) | (msg[k + 1] << 16) | (msg[k + 2] << 8) | msg[k + 3];
    } else {
      w = (msg[k + 3] << 24) | (msg[k + 2] << 16) | (msg[k + 1] << 8) | msg[k];
    }
    res[i] = w;
  }
  return res;
}

int _shiftl32(int x, int n) {
  n &= _mask_5;
  x &= _mask32_hi_bits[n];
  return (x << n) & _mask_32;
}

int _rotl32(int x, int n) {
  return (_shiftl32(x, n)) | (x >> (32 - n) & _mask_32);
}

int _sum32(int a, [int b = 0, int c = 0, int d = 0, int e = 0]) {
  return (a + b + c + d + e) & _mask_32;
}

Uint8List _split32(List<int> msg, Endian endian) {
  var res = ByteData(msg.length * 4);
  for (var i = 0, k = 0; i < msg.length; i++, k += 4) {
    var m = msg[i];
    res.setUint32(k, m, endian);
  }
  return res.buffer.asUint8List();
}

class _Hash {
  late List<int>? pending;
  int pendingTotal = 0;
  int blockSize;
  int padLength;
  int outSize;
  Endian endian = Endian.big;

  late int _delta8;
  late int _delta32;
  _Hash({required this.blockSize, required this.padLength, required this.outSize, required this.endian}) {
    padLength = padLength ~/ 8;
    _delta8 = blockSize ~/ 8;
    _delta32 = blockSize ~/ 32;
    reset();
  }

  void reset() {
    pendingTotal = 0;
    pending = null;
  }

  void _update(List<int> msg, int start) {}

  _Hash update(List<int> msg) {
    if (pending?.isEmpty ?? true) {
      pending = List.from(msg);
    } else {
      pending!.addAll(msg);
    }
    pendingTotal += msg.length;

    if (pending!.length >= _delta8) {
      msg = pending!;

      var r = msg.length % _delta8;
      pending = msg.sublist(msg.length - r, msg.length);
      if (pending?.isEmpty ?? true) {
        pending = null;
      }
      msg = _join32(msg, 0, msg.length - r, endian);
      for (var i = 0; i < msg.length; i += _delta32) {
        _update(msg, i);
      }
    }

    return this;
  }

  Uint8List _pad() {
    var len = pendingTotal;
    var k = _delta8 - ((len + padLength) % _delta8);
    var res = ByteData(k + padLength);
    res.setUint8(0, 0x80);
    int i;
    for (i = 1; i < k; i++) {
      res.setUint8(i, 0);
    }

    len <<= 3;
    if (endian == Endian.big) {
      for (var t = 8; t < padLength; t++) {
        res.setUint8(i++, 0);
      }
      res.setUint32(i, 0);
      i += 4;
      res.setUint32(i, len);
      i += 4;
    } else {
      res.setUint32(i, len, Endian.little);
      i += 4;
      res.setUint32(i, 0);

      for (var t = 8; t < padLength; t++) {
        res.setUint8(i++, 0);
      }
    }

    return res.buffer.asUint8List();
  }

  Uint8List _digest() {
    return Uint8List(0);
  }

  Uint8List digest() {
    update(_pad());

    assert(pending == null);

    return _digest();
  }
}

class _MD5 extends _Hash {
  _MD5() : super(blockSize: 512, padLength: 64, outSize: 16, endian: Endian.little);

  final List<int> _h = List.filled(4, 0);

  @override
  void reset() {
    super.reset();
    _h[0] = 0x67452301;
    _h[1] = 0xefcdab89;
    _h[2] = 0x98badcfe;
    _h[3] = 0x10325476;
  }

  @override
  void _update(List<int> msg, int start) {
    var a = _h[0];
    var b = _h[1];
    var c = _h[2];
    var d = _h[3];
    int e;
    int f;

    for (var i = 0; i < 64; i++) {
      if (i < 16) {
        e = (b & c) | ((~b & _mask_32) & d);
        f = i;
      } else if (i < 32) {
        e = (d & b) | ((~d & _mask_32) & c);
        f = ((5 * i) + 1) % 16;
      } else if (i < 48) {
        e = b ^ c ^ d;
        f = ((3 * i) + 5) % 16;
      } else {
        e = c ^ (b | (~d & _mask_32));
        f = (7 * i) % 16;
      }
      var temp = d;
      d = c;
      c = b;
      b = _sum32(b, _rotl32(_sum32(_sum32(a, e), _sum32(_n[i], msg[f])), _sa[i]));
      a = temp;
    }

    _h[0] = _sum32(a, _h[0]);
    _h[1] = _sum32(b, _h[1]);
    _h[2] = _sum32(c, _h[2]);
    _h[3] = _sum32(d, _h[3]);
  }

  @override
  Uint8List _digest() {
    return _split32(_h, endian);
  }
}

String md5str(String input) {
  if (input.isEmpty) return '';

  var md5 = _MD5();
  final bytes = utf8.encode(input);
  final digest = md5.update(bytes).digest();

  var str = '';
  for (var i = 0; i < digest.length; i++) {
    var s = digest[i].toRadixString(16);
    str += s.padLeft(2, '0');
  }
  return str;
}

extension StringMd5Ext on String {
  String get md5 => md5str(this);
}
