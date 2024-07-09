import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://pjbelo.medium.com/flutter-webview-a-simple-demo-74fa6bb476d5

// 웹뷰 뒤로가기
// https://kbwplace.tistory.com/175

class WebViewPackagesScreen extends StatefulWidget {
  const WebViewPackagesScreen({super.key});

  @override
  State<WebViewPackagesScreen> createState() => _WebViewPackagesScreenState();
}

class _WebViewPackagesScreenState extends State<WebViewPackagesScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      body: WebView(
        initialUrl: 'https://www.naver.com/',
      ),
    );
  }
}
