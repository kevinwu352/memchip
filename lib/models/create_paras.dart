class CreateParas {
  String server;
  String token;
  String key;
  String url;

  CreateParas({required this.server, required this.token, required this.key, required this.url});

  factory CreateParas.fromApi(Map<String, dynamic> json) {
    final url = json['fileURL'] as String;

    final options = json['uploadFileOptions'] as Map;
    final server = options['url'] as String;

    final data = options['formData'] as Map;
    final token = data['token'] as String;
    final key = data['key'] as String;

    return CreateParas(server: server, token: token, key: key, url: url);
  }
}
