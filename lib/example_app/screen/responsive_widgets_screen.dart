import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// Expanded
// Row, Column 안에 공간에서 차지할 수 있는 공간을 전부 채우는 기능
// 자식(Child)이 사용 가능한 공간을 채우도록 행(Row), 열(Column) 또는 유연한영역(Flex)의 자식을 확장하는 위젯.

// Flexible
// Row, Column 여유 공간을 활용하는 기능, 위젯들이 차지하는 영역을 비율로 나눌 수 있다.

class ResponsiveWidgetsScreen extends StatelessWidget {
  const ResponsiveWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1400,
            child: Column(
              // 참고 사이트
              // https://seosh817.tistory.com/83
              // https://devmg.tistory.com/195
              children: [
                Expanded(child: Container(color: Colors.lightGreen,)),
                Flexible(child: Container(color: Colors.blueGrey,)),
                Row(
                  children: [
                    Container(
                      width: 300, height: 100, color: Colors.yellow,
                    ),
                    Flexible(
                      flex: 1, // default
                      fit: FlexFit.loose, // default
                      child: Container(
                        width: 100, height: 100, color: Colors.blue,
                      )
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 200, height: 100, color: Colors.yellow,
                    ),
                    Flexible(
                      fit: FlexFit.loose, // default
                      child: Container(
                        width: 70, height: 100, color: Colors.blue,
                      )
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 300, height: 100, color: Colors.yellow,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        width: 100, height: 100, color: Colors.blue,
                      )
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 200, height: 100, color: Colors.yellow,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        width: 70, height: 100, color: Colors.blue,
                      )
                    ),
                  ],
                ),

                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 100, color: Colors.cyan,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: 100, color: Colors.orange,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        height: 100, color: Colors.brown,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 300, height: 100, color: Colors.yellow,
                    ),
                    Expanded(
                      flex: 1, // default
                      child: Container(
                        width: 100, height: 100, color: Colors.blue,
                      )
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      color: Colors.green,
                      child: const Text('제일 긴 박스 입니다.'),
                    ),
                    Container(
                      height: 100,
                      color: Colors.red,
                      child: const Text('빨간색 박스.'),
                    ),
                    Container(
                      height: 100,
                      color: Colors.yellow,
                      child: const Text('노랑색 박스.'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      color: Colors.green,
                      child: const Text('제일 긴 박스 입니다.'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스.'),
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.yellow,
                      child: const Text('노랑색 박스.'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.green,
                        child: const Text('제일 긴 박스 입니다.'),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스.'),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.yellow,
                        child: const Text('노랑색 박스.'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.green,
                        child: const Text('제일 긴 박스 입니다.'),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스.'),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.yellow,
                        child: const Text('노랑색 박스.'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      color: Colors.green,
                      child: const Text('제일 긴 박스 입니다.'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스.'),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: 100,
                        color: Colors.yellow,
                        child: const Text('노랑색 박스.'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      color: Colors.green,
                      child: const Text('제일 긴 박스 입니다.'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스.'),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: Container(
                        height: 100,
                        color: Colors.yellow,
                        child: const Text('노랑색 박스.'),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Container(
                      height: 100,
                      color: Colors.green,
                      child: const Text('초록색 박스.'),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스 입니다 1234567891011121314151617181920!!!!!!!!!!!!!!!!!!.'),
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.yellow,
                      child: const Text('노랑색 박스.'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 100,
                      color: Colors.green,
                      child: const Text('초록색 박스.'),
                    ),
                    Flexible(
                      child: Container(
                        height: 100,
                        color: Colors.red,
                        child: const Text('빨간색 박스 입니다 1234567891011121314151617181920!!!!!!!!!!!!!!!!!!.'),
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.yellow,
                      child: const Text('노랑색 박스.'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
