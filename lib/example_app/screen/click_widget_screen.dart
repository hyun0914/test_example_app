import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

// 참고 사이트
// https://ahang.tistory.com/15
// https://stcodelab.com/entry/Flutter-Inkwell-%EA%B3%BC-GestureDetector-%ED%84%B0%EC%B9%98-%ED%81%B4%EB%A6%AD-%EC%9D%B8%EC%8B%9D

class ClickWidgetScreen extends StatelessWidget {
  const ClickWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  snackBarView(context: context, message: 'InkWell-onTap');
                },
                child: const Text('InWell 위젯', style: TextStyle(fontSize: 17),),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  snackBarView(context: context, message: 'GestureDetector-onTap');
                },
                child: const Text('GestureDetector 위젯(onTap)', style: TextStyle(fontSize: 17),),
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onDoubleTap: () {
                  snackBarView(context: context, message: 'GestureDetector-onDoubleTap');
                },
                child: const Text('GestureDetector 위젯(onDoubleTap)', style: TextStyle(fontSize: 17),),
              ),
              const SizedBox(height: 20,),
              MaterialButton(
                onPressed: () {
                  snackBarView(context: context, message: 'MaterialButton-onPressed');
                },
                child: const Text('MaterialButton 위젯', style: TextStyle(fontSize: 17),),
              ),
              ElevatedButton(
                onPressed: () {
                  snackBarView(context: context, message: 'ElevatedButton-onPressed');
                },
                child: const Text('ElevatedButton 위젯', style: TextStyle(fontSize: 17),),
              ),
              // 참고 사이트
              // https://blueoceannshark.tistory.com/entry/flutter-ElevatedButton-border-radiusElevatedbutton-%EB%91%A5%EA%B8%80%EA%B2%8C
              ElevatedButton(
                onPressed: () {
                  snackBarView(context: context, message: 'ElevatedButton-onPressed-RoundedRectangleBorder');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('ElevatedButton 위젯', style: TextStyle(fontSize: 17),),
              ),
              ElevatedButton(
                onPressed: () {
                  snackBarView(context: context, message: 'ElevatedButton-onPressed-BeveledRectangleBorder');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('ElevatedButton 위젯', style: TextStyle(fontSize: 17),),
              ),
              ElevatedButton(
                onPressed: () {
                  snackBarView(context: context, message: 'ElevatedButton-onPressed-CircleBorder');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text('EB 위젯', style: TextStyle(fontSize: 17),),
              ),
              TextButton(
                onPressed: () {
                  snackBarView(context: context, message: 'TextButton-onPressed');
                },
                child: const Text('TextButton 위젯', style: TextStyle(fontSize: 17),),
              ),
              // 아이콘 버튼 클릭시 나오는 효과 없애기
              IconButton(
                highlightColor: Colors.transparent,
                onPressed: (){
                  snackBarView(context: context, message: 'IconButton-onPressed');
                },
                icon: const Icon(Icons.add_circle)
              ),

              // 참고사이트
              // https://jinhan38.com/130
              // https://stackoverflow.com/questions/59478364/how-to-use-ontap-or-onpressed-in-popupmenuitem
              PopupMenuButton(
                icon: const Icon(Icons.more_horiz),
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 0,
                      child: Text('아이템 0')
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('아이템 1')
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text('아이템 2')
                    ),
                  ];
                }
              ),
              ToggleSwitch(
                initialLabelIndex: 0,
                totalSwitches: 4,
                labels: const ['모니터', '본체', '키보드', '마우스'],
                onToggle: (index) {
                  snackBarView(context: context, message: 'ToggleSwitch-onToggle $index');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
