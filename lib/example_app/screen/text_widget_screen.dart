import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

class TextWidgetScreen extends StatelessWidget {
  const TextWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: Column(
        children: [
          // 참고 사이트
          // https://eunjin3786.tistory.com/421
          // https://iosroid.tistory.com/36
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: '텍스트 ', style: TextStyle(color: Colors.brown)),
                TextSpan(text: '텍스트10 ', style: TextStyle(color: Colors.indigo, fontSize: 20)),
                TextSpan(text: '각각 스타일 적용', style: TextStyle(color: Colors.green)),
              ]
            )
          ),

          const Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '텍스트 ', style: TextStyle(color: Colors.brown)),
                TextSpan(text: '텍스트10 ', style: TextStyle(color: Colors.indigo, fontSize: 20)),
                TextSpan(text: '각각 스타일 적용', style: TextStyle(color: Colors.green)),
              ]
            )
          ),

          // 참고 사이트
          // https://80000coding.oopy.io/5baeee62-0ec4-4f7f-82b7-36707019f725
          EasyRichText(
            '텍스트 텍스트10 각각 스타일 적용',
            defaultStyle: const TextStyle(color: Colors.brown),
            patternList: const [
              EasyRichTextPattern(
                targetString: '텍스트10',
                style: TextStyle(color: Colors.indigo, fontSize: 20),
              ),
              EasyRichTextPattern(
                targetString: '각각 스타일 적용',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
