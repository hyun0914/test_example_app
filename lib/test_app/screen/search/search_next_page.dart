import 'package:flutter/material.dart';

import '../community/community_page.dart';
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
        Expanded(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Center(child: Text(getTest, style: const TextStyle(fontSize: 20),)),
                ),
              ),
              communityList(childCount: 40)
            ],
          ),
        )
      ]
    );
  }
}
