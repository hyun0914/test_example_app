import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://stackoverflow.com/questions/62355547/visibility-vs-offstage-vs-opacity-which-is-best-in-hiding-a-child-from-widget-t
//

class HideWidgetsScreen extends StatelessWidget {
  const HideWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // visible: false 일 경우 위젯 표시 안됨
                Visibility(
                  visible: true,
                  child: Text('Visibility 위젯'),
                ),

                // offstage: true 일 경우 위젯 표시 안됨
                Offstage(
                  offstage: false,
                  child: Text('Offstage 위젯'),
                ),

                // opacity: 0 일 경우 위젯 표시 안됨
                Opacity(
                  opacity: 1,
                  child: Text('Opacity 위젯'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
