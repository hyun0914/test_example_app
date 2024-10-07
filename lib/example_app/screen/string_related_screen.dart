import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class StringRelatedScreen extends StatelessWidget {
  const StringRelatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String str_01 = '    Flutter에서 문자열의 공백을 제거하는 방법    ';
    String str_02 = 'Flutter에서 문자열의 공백을 제거하는 방법';
    return DefaultScaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                String trimStr = str_01.trim();
                snackBarView(context: context, message: '$str_01\n$trimStr');
              },
              child: const Text('앞,뒤 공백 제거 방법')
            ),
            ElevatedButton(
              onPressed: () {
                String replaceAllStr = str_02.replaceAll(' ', '');
                snackBarView(context: context, message: '$str_02\n$replaceAllStr');
              },
              child: const Text('공백 제거 방법 1')
            ),
            ElevatedButton(
              onPressed: () {
                String regExpStr = str_02.replaceAll(RegExp(r'\s+'), '');
                snackBarView(context: context, message: '$str_02\n$regExpStr');
              },
              child: const Text('공백 제거 방법 2')
            ),
          ],
        ),
      ),
    );
  }
}