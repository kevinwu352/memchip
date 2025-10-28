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
    webvc = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) async {
            final prog = value / 100;
            final ttl = await webvc.getTitle();
            setState(() {
              progress = prog;
              title = ttl ?? '';
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? 'about:blank'));
  }

  late WebViewController webvc;
  String title = '';
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Stack(
        children: [
          WebViewWidget(controller: webvc),
          if (progress < 0.95) LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}
