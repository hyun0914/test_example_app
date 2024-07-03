import 'package:flutter/material.dart';
import '../layout/simple_bar_layout.dart';

class BannerDetailsPage extends StatelessWidget {
  final String imgName;
  const BannerDetailsPage({
    required this.imgName,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBarLayout(
      title: '광고',
      topIcon: null,
      children: [
        Image.asset(
          imgName,
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
