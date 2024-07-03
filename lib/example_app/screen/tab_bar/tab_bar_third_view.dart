import 'package:flutter/material.dart';

import '../widget/basic_header_delegate.dart';

// 참고 사이트
// https://dalgoodori.tistory.com/62

class TabBarThirdView extends StatelessWidget {
  const TabBarThirdView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: BasicHeaderDelegate(
            child: Container(
              color: Colors.indigo,
              child: const Center(child: Text('고정')),
            ),
            maxHeight: 100,
            minHeight: 40,
          ),
        ),

        // 단일 위젯 사용법
        // 일반적인 위젯을 사용 할 수 있게 하는 위젯
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                width: 200,
                height: 300,
                color: Colors.teal,
              ),
              Container(
                width: 200,
                height: 600,
                color: Colors.green,
              ),
            ],
          ),
        )
      ],
    );
  }
}
