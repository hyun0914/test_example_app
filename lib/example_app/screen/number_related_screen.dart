import 'package:flutter/material.dart';
import 'dart:math';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class NumberRelatedScreen extends StatelessWidget {
  const NumberRelatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  // 참고 사이트 https://m.blog.naver.com/chandong83/221950042761
                  onPressed: () async{
                    await getRandom().then((value) {
                      snackBarView(
                        context: context,
                        message: '랜덤 숫자,문자: $value\n'
                      );
                    });
                  },
                  child: const Text('랜덤 숫자,문자 생성')
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  // 참고 사이트 https://api.dart.dev/stable/3.0.5/dart-core/num/abs.html
                  onPressed: () {
                    // 숫자값 상수로 변경하기
                    int minusNumber = -10;
                    int absNumber = minusNumber.abs();
                    snackBarView(
                      context: context,
                      message: 'minusNumber: $minusNumber\nabsNumber: $absNumber\n'
                    );
                  },
                  child: const Text('상수 abs()')
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // 참고 사이트
                    // https://velog.io/@ssh0407/dart-%EC%88%AB%EC%9E%90-%EC%98%AC%EB%A6%BC-%EB%B2%84%EB%A6%BC-%EB%B0%98%EC%98%AC%EB%A6%BC-%EC%86%8C%EC%88%98%EC%A0%90-%EA%B8%B8%EC%9D%B4-%EA%B3%A0%EC%A0%95
                    double decimalPoint = 4.9999;
                    snackBarView(
                      context: context,
                      message:
                      'decimalPoint: $decimalPoint\n'
                      // 올림
                      'decimalPoint 올림: ${decimalPoint.ceil()}\n'
                      // 버림
                      'decimalPoint 버림: ${decimalPoint.floor()}\n'
                      // 반올림
                      'decimalPoint 반올림: ${decimalPoint.round()}\n'
                      // 소수점 고정
                      'decimalPoint 소수점 고정: ${decimalPoint.toStringAsFixed(2)}\n'
                    );
                  },
                  child: const Text('소수점 관련')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Future getRandom() async {
  dynamic randomStr = Random();
  //무조건 들어갈 문자종류(문자,숫자,특수기호)의 위치를 기억할 리스트
  dynamic leastCharacterIndex = [];
  // '+', '-', ' ' 사용하지 않을 아스키 문자
  dynamic skipCharacter = [0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, 0x60];
  dynamic min = 0x30; // start ascii 사용할 아스키 문자의 시작
  dynamic max = 0x7A; // end ascii   사용할 아스키 문자의 끝
  dynamic dat = [];   // 저장용 리스트
  while(dat.length <= 5) { //무작위로 32개를 생성한다
    var tmp = min + randomStr.nextInt(max - min); //랜덤으로 아스키값 받기
    if(skipCharacter.contains(tmp)) { //사용하지 않을 아스키 문자인지 확인
      //print('skip ascii code $tmp.');
      continue;
    }
    //dat 리스트에 추가
    dat.add(tmp);
  }
  print(dat);
  return String.fromCharCodes(dat.cast<int>());
}