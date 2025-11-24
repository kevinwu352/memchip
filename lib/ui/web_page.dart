import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key, this.url});
  final String? url;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();
    _webvc = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) async {
            final progress = value / 100;
            final title = await _webvc.getTitle();
            setState(() {
              _progress = progress;
              _title = title ?? '';
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? 'about:blank'));
  }

  late WebViewController _webvc;
  String _title = '';
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Stack(
        children: [
          WebViewWidget(controller: _webvc),
          if (_progress < 0.95) LinearProgressIndicator(value: _progress),
        ],
      ),
    );
  }
}
