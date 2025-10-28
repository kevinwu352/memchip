extension StringUriExt on String {
  String get encodeComponent => Uri.encodeComponent(this);
  String get decodeComponent => Uri.decodeComponent(this);
}
