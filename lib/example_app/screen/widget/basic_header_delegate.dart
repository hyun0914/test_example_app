import 'package:flutter/material.dart';

// SliverPersistentHeader 최소, 최대 상태

class BasicHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  BasicHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if(shrinkOffset >= minExtent) {
      // 최소 크기일 경우 처리
    }
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight; // 최대 크기

  @override
  double get minExtent => minHeight; // 최소 크기

  @override
  bool shouldRebuild(BasicHeaderDelegate oldDelegate) {
    // 헤더의 외관 변경 여부 반환
    return false;
  }
}