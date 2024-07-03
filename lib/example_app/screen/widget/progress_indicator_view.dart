import 'package:flutter/material.dart';

// 참고 사이트
// https://velog.io/@sharveka_11/Flutter-48.-CircularProgressIndicator
// https://engschool.tistory.com/166

class ProgressIndicatorView extends StatefulWidget {
  const ProgressIndicatorView({super.key});

  @override
  State<ProgressIndicatorView> createState() => _ProgressIndicatorViewState();
}

class _ProgressIndicatorViewState extends State<ProgressIndicatorView> with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<Color?> colorTween;

  @override
  void initState() {
    super.initState();
    if(mounted) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
      )..addListener(() {
        setState(() {});
      });
    }

    colorTween = controller.drive(ColorTween(begin: Colors.green, end: Colors.teal));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
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
              '${(controller.value *100).toInt()}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          CircularProgressIndicator(
            strokeWidth: 4,
            value: controller.value,
            valueColor: colorTween,
          ),
          const SizedBox(height: 10,),
          LinearProgressIndicator(
            value: controller.value,
            valueColor: colorTween,
          ),
        ],
      ),
    );
  }
}
