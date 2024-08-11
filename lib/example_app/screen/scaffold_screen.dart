import 'package:flutter/material.dart';

// Drawer의 상태 확인
// scaffoldKey.currentState!.isDrawerOpen
// scaffoldKey.currentState!.isEndDrawerOpen
// 참고 사이트
// https://stackoverflow.com/questions/60314156/close-navigation-drawer-on-back-button-pressed-in-flutter

// 참고 사이트
// https://velog.io/@jehjong/BuildContext

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ScaffoldScreen extends StatelessWidget {
  const ScaffoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // centerTitle
        // true - 중앙 정렬
        // false - 왼쪽 정렬
        // ios 기본설정이 중앙정렬, aos 기본설정이 왼쪽정렬
        // 참고 사이트
        // https://islet4you.tistory.com/entry/Flutter-AppBar-title-center-%EB%A1%9C-%EB%A7%9E%EC%B6%B0%EC%A3%BC%EA%B8%B0
        centerTitle: true,
        title: const Text('Drawer'),
        // drawer => leading 안에 아이콘 or 이미지
        // enddrawer => actions 안에 아이콘 or 이미지
        // leading: Icon(Icons.tab),
        // actions: [
        //   Icon(Icons.tab)
        // ],
        // 참고 사이트 https://www.youtube.com/watch?v=m0nEbAEnt9g
      ),
      endDrawer: const Drawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if(!scaffoldKey.currentState!.isEndDrawerOpen) {
                  scaffoldKey.currentState!.openEndDrawer();
                }
                print(scaffoldKey.currentState!.isDrawerOpen);
                print(scaffoldKey.currentState!.isEndDrawerOpen);
              },
              child: const Center(
                child: Text('Drawer 열기'),
              )
            ),

            // 참고 사이트 https://th-biglight.tistory.com/26
            Builder(
              builder: (context) {
                return ElevatedButton(onPressed: () => Scaffold.of(context).openEndDrawer(), child: const Text('Drawer 열기2'),);
              }
            )
          ],
        ),
      ),
    );
  }
}
