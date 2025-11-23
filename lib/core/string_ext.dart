extension StringUriExt on String {
  String get componentEncoded => Uri.encodeComponent(this);
  String get componentDecoded => Uri.decodeComponent(this);
}
