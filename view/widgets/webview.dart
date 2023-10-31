import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookWebView extends StatefulWidget {
  final String url;

  BookWebView(this.url);

  @override
  _BookWebViewState createState() => _BookWebViewState(this.url);
}

class _BookWebViewState extends State<BookWebView> {
  WebViewController? _controller;

  var url;

  _BookWebViewState(this.url);

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Book Details'),
        ),
        body: WebViewWidget(controller: _controller!));
  }
}
