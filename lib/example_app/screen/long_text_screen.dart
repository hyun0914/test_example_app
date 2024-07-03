import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// 참고사이트
// https://jj-k-ul.tistory.com/entry/Flutter-Text-Overflow-%EB%AC%B8%EC%9E%90-%EC%A4%84%EB%B0%94%EA%BF%88-%EB%A7%90%EC%A4%84%EC%9E%84-%ED%8E%98%EC%9D%B4%EB%93%9C
// https://d-dual.tistory.com/7

class LongTextScreen extends StatelessWidget {
  const LongTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: Column(
          children: [
            // overflow: TextOverflow.clip
            // 넘치는 텍스트 표시 안함
            Row(
              children: [
                Container(
                  width: 300,
                  height: 88,
                  color: Colors.grey,
                  child: const Text(
                    '12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하',
                    style: TextStyle(fontSize: 16, overflow: TextOverflow.clip),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            // overflow: TextOverflow.fade
            // 넘치는 텍스트 투명화
            Row(
              children: [
                Container(
                  width: 300,
                  height: 88,
                  color: Colors.grey,
                  child: const Text(
                    '12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하',
                    style: TextStyle(fontSize: 16, overflow: TextOverflow.fade),
                    // 효과를 수평으로 적용
                    // softWrap: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            // overflow: TextOverflow.ellipsis
            // 넘치는 텍스트 ... 으로 표시
            Row(
              children: [
                Container(
                  width: 300,
                  height: 88,
                  color: Colors.grey,
                  child: const Text(
                    '12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하',
                    style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            // overflow: TextOverflow.ellipsis
            // 넘치는 텍스트 잘리지 않고 표시
            Row(
              children: [
                Container(
                  width: 300,
                  height: 88,
                  color: Colors.grey,
                  child: const Text(
                    '12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하 12345678910 가나다라마바사아자차카타파하',
                    style: TextStyle(fontSize: 16, overflow: TextOverflow.visible),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
