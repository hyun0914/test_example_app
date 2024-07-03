import 'package:flutter/material.dart';

import '../layout/simple_bar_layout.dart';

class SearchNextPage extends StatelessWidget {
  final String getTest;
  const SearchNextPage({
    required this.getTest,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '검색결과',
      topIcon: null,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: Center(child: Text(getTest, style: const TextStyle(fontSize: 20),)),
        ),
      ]
    );
  }
}
