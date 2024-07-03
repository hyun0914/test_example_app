import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://mik-a.com/93?category=855885
// https://titann.tistory.com/51

class PrintScreen extends StatelessWidget {
  const PrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){print('테스트');}, child: const Text('print')),
              // Don't invoke 'print' in production code. 하면서 사용하지 말라고 한다.
              // flutter에서 권장 하는 사용법
              ElevatedButton(onPressed: (){debugPrint('테스트');}, child: const Text('debugPrint')),
              ElevatedButton(onPressed: (){log('테스트');}, child: const Text('log')),
              // 패키지
              // logger
              // 참고 사이트
              // https://bangu4.tistory.com/350
              // https://byounghonglim.tistory.com/149
              ElevatedButton(onPressed: (){logger.t("Trace log");}, child: const Text('logger.t')),
              ElevatedButton(onPressed: (){logger.d("Debug log");}, child: const Text('logger.d')),
              ElevatedButton(onPressed: (){logger.i("Info log");}, child: const Text('logger.i')),
              ElevatedButton(onPressed: (){logger.w("Warning log");}, child: const Text('logger.w')),
              ElevatedButton(onPressed: (){logger.e("Error log");}, child: const Text('logger.e')),
              // wtf => f
              ElevatedButton(onPressed: (){logger.f("fatal log");}, child: const Text('logger.f')),
            ],
          ),
        ),
      ),
    );
  }
}
