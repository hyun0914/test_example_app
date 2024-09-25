import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://velog.io/@kjha2142/Flutter-GridView

class GridViewWidgetScreen extends StatelessWidget {
  const GridViewWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 6,
          childAspectRatio: 0.9,
        ),
        itemCount: 40,
        itemBuilder: (BuildContext context, int index) {
          return  Container(
            color: Colors.green,
          );
        },
      ),
    );
  }
}
