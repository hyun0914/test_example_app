import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

// 참고 사이트
// flutter button trigger

// GlobalKey 방법
// https://morioh.com/a/3f8f86ed3291/flutter

// MaterialStatesController 방법
// https://stackoverflow.com/questions/74372506/flutter-programatically-perform-a-button-click

class ButtonTriggerScreen extends StatefulWidget {
  const ButtonTriggerScreen ({super.key});

  @override
  State<ButtonTriggerScreen> createState() => _ButtonTriggerScreenState();
}

class _ButtonTriggerScreenState extends State<ButtonTriggerScreen> {
  @override
  Widget build(BuildContext context) {
    final triggerKey = GlobalKey();
    WidgetStatesController statesController = WidgetStatesController();
    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                key: triggerKey,
                statesController: statesController,
                onPressed: () {
                  snackBarView(
                    context: context,
                    message: '버튼 1'
                  );
                },
                child: const Text('버튼 1')
              ),
              ElevatedButton(
                onPressed: () {
                  RenderBox renderBox = triggerKey.currentContext!.findRenderObject() as RenderBox;
                  Offset position = renderBox.localToGlobal(Offset.zero);
                  double x = position.dx;
                  double y = position.dy;

                  print(x);
                  print(y);

                  // 버튼 눌렀을 때
                  GestureBinding.instance.handlePointerEvent(PointerDownEvent(
                    position: Offset(x, y),
                  ));

                  // 버튼 뗄때
                  GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                    position: Offset(x, y),
                  ));
                },
                child: const Text('버튼 2')
              ),
              ElevatedButton(
                onPressed: () async {
                  // useMaterial3: false 일때 눌러진 효과만 보임
                  statesController.update(WidgetState.pressed, true);
                  await Future.delayed(const Duration(milliseconds: 100));
                  statesController.update(WidgetState.pressed, false);
                },
                child: const Text('버튼 3')
              ),
            ],
          ),
        ),
      ),
    );
  }
}