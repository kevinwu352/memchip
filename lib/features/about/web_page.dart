import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();
    webvc = WebViewController()..loadRequest(Uri.parse('https://www.baidu.com'));
  }

  late WebViewController webvc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('--')),
      body: WebViewWidget(controller: webvc),
    );
  }
}
