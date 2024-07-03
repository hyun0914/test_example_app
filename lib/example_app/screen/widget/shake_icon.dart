import 'dart:async';

import 'package:flutter/material.dart';

// 참고 사이트 flutter animated 좌우 움직임
// https://m.blog.naver.com/yhyn37/221952097496
enum ShakeEnum { repeat, awhile, unwavering, }

class ShakeIcon extends StatefulWidget {
  final ShakeEnum shakeMode;
  final double shakeWidth;
  final int duration;
  final Widget child;
  const ShakeIcon({
    required this.shakeMode,
    required this.shakeWidth,
    required this.duration,
    required this.child,
    super.key
  });

  @override
  State<ShakeIcon> createState() => _ShakeIconState();
}

class _ShakeIconState extends State<ShakeIcon> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    if(mounted) {
      controller = AnimationController(duration: const Duration(milliseconds: 40), vsync: this);
      animation = Tween(begin: 0.0, end: widget.shakeWidth).animate(controller);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shakeMode == ShakeEnum.unwavering) {
      controller.stop();
    }
    else {
      controller.repeat(reverse: true);
      if (widget.shakeMode == ShakeEnum.awhile) {
        Timer(Duration(milliseconds: widget.duration), () => controller.stop());
      }
    }
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double x = 0;
        if (animation.value != widget.shakeWidth) {
          x = animation.value - (widget.shakeWidth / 2);
        }
        return Transform.translate(
          offset: Offset(x, 0),
          child: widget.child,
        );
      },
    );
  }
}