import 'package:flutter/material.dart';

import 'tab_bar/tab_bar_first_view.dart';
import 'tab_bar/tab_bar_second_view.dart';
import 'tab_bar/tab_bar_third_view.dart';
import 'widget/default_scaffold.dart';

// TabBar 참고 사이트
// https://eunoia3jy.tistory.com/110
// https://dkswnkk.tistory.com/200
// https://jinhan38.com/140?category=978038
// https://docs.flutter.dev/cookbook/design/tabs

List<String> tabsText = ['첫번 째', '두번 째', '세번 째'];

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsText.length,
      child: DefaultScaffold(
        appBar: AppBar(
         bottom: TabBar(
           indicatorPadding: const EdgeInsets.only(left: 2, right: 2),
           indicatorColor: const Color.fromRGBO(0, 109, 72, 1),
           labelColor: const Color.fromRGBO(0, 109, 72, 1),
           unselectedLabelColor: const Color.fromRGBO(101, 101, 101, 1),
           tabs: [
             for(int i=0; i<tabsText.length; i++)
             Text(tabsText[i]),
           ],
         ),
        ),
        body: const SafeArea(
          child: TabBarView(
            // 참고 사이트
            // https://velog.io/@adbr/Flutter-TabBarView-%EC%8A%A4%EC%99%80%EC%9D%B4%ED%94%84-%EB%A7%89%EA%B8%B0-disable-swiping-tabs-in-TabBar-flutter
            // physics: ClampingScrollPhysics(), // 정상
            // physics: NeverScrollableScrollPhysics(), // 탭 중지
            // physics: BouncingScrollPhysics(), // 시작, 끝 bouncing 스크롤 효과 생김
            children: [
              TabBarFirstView(),
              TabBarSecondView(),
              TabBarThirdView(),
            ],
          ),
        ),
      ),
    );
  }
}
