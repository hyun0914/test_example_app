import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

// 참고 사이트
// https://velog.io/@sharveka_11/Flutter-48.-CircularProgressIndicator
// https://engschool.tistory.com/166
// https://velog.io/@qazws78941/Flutter-Progress-Indicator

class ProgressIndicatorView extends StatefulWidget {
  const ProgressIndicatorView({super.key});

  @override
  State<ProgressIndicatorView> createState() => _ProgressIndicatorViewState();
}

class _ProgressIndicatorViewState extends State<ProgressIndicatorView> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<Color?> colorTween;

  @override
  void initState() {
    super.initState();
    if(mounted) {
      animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
      )..addListener(() {
        setState(() {});
      });
    }

    colorTween = animationController.drive(ColorTween(begin: Colors.green, end: Colors.teal));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Center(
            child: Text(
              '${(animationController.value *100).toInt()}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          CircularProgressIndicator(
            strokeWidth: 4,
            value: animationController.value,
            valueColor: colorTween,
          ),
          const SizedBox(height: 10,),
          LinearProgressIndicator(
            value: animationController.value,
            valueColor: colorTween,
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
