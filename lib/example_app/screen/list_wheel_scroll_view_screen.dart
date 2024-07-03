import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://stackoverflow.com/questions/74592605/synchronizing-listwheelscrollview-in-flutter
// https://flutterexperts.com/listwheelscrollview-in-flutter/

class ListWheelScrollViewScreen extends StatelessWidget {
  const ListWheelScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: ListWheelScrollView(
        itemExtent: 100,
        // useMagnifier: true,
        // magnification: 1.5,
        children: [
          for(int i=0; i<30; i++)
          Container(
            width: 400,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),
          )
        ]
      ),
    );
  }
}
