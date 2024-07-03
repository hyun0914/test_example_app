import 'package:flutter/material.dart';

import '../layout/simple_bar_layout.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '이미지 상세',
      topIcon: const [],
      children: [
        // 참고 사이트
        // https://black-glasses.tistory.com/entry/Flutter-%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%9D%B4%EB%AF%B8%EC%A7%80-%ED%99%95%EB%8C%80%ED%95%98%EA%B8%B0-InteractiveViewer%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%9E%90
        // 이미지를 확대 축소 할때 사용하는 위젯
        InteractiveViewer(child: Image.asset('assets/images/pizza.png')),
      ],
    );
  }
}
