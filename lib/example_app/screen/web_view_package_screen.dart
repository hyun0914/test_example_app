import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://velog.io/@tygerhwang/Flutter-WebView-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-1%ED%8E%B8

// 웹뷰 뒤로가기
// https://kbwplace.tistory.com/175

class WebViewPackageScreen extends StatefulWidget {
  const WebViewPackageScreen({super.key});

  @override
  State<WebViewPackageScreen> createState() => _WebViewPackageScreenState();
}

class _WebViewPackageScreenState extends State<WebViewPackageScreen> {
  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://naver.com'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: WebViewWidget(controller: webViewController!),
    );
  }
}
