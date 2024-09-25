import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'community/community_page.dart';
import 'mypage/my_page.dart';
import 'search/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key,});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  FocusNode searchFocus = FocusNode();

  DateTime? backPressTime;

  bool isShowFab = true;

  void onBackTwo() {
    DateTime now = DateTime.now();
    if(backPressTime == null || now.difference(backPressTime!) > const Duration(seconds: 2)){
      backPressTime = now;
      toastView('뒤로가기 버튼을 한번 더 누르시면 종료 됩니다.');
    }
  }

  int currentIndex = 0;
  final List<Widget> screenList = <Widget> [
    const CommunityPage(),
    const MyPage(),
  ];

  void cheekConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if(connectivityResult.contains(ConnectivityResult.wifi)){
      toastView('WIFI 사용 중 입니다.');
    }
    else if(connectivityResult.contains(ConnectivityResult.mobile)){
      toastView('모바일데이터 사용 중 입니다.');
    }
    else if(connectivityResult.contains(ConnectivityResult.none)){
      toastView('네트워크 연결을 확인하세요.');
    }
  }

  @override
  void initState() {
    super.initState();
    cheekConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    var controller = PrimaryScrollController.of(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          const SizedBox(width: 14,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.search, color: Colors.black,),
                        SizedBox(width: 8,),
                        Text('통합검색', style: TextStyle(color: Colors.black,),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14,),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton 스크롤 시 숨기기
      // 참고 사이트 https://stackoverflow.com/questions/45631350/flutter-hiding-floatingactionbutton
      body: NotificationListener<UserScrollNotification> (
        onNotification: (notification){
          final ScrollDirection direction = notification.direction;
          if (direction == ScrollDirection.reverse) {
            // ScrollDirection.reverse일때 숨기고
            setState(() {
              isShowFab = false;
            });
          }
          else if (direction == ScrollDirection.forward) {
            // ScrollDirection.forward 일때 다시 표시
            setState(() {
              isShowFab = true;
            });
          }
          return true;
        },
        child: Center(
          child: Container(
            width: 720,
            margin: const EdgeInsets.only(bottom: kToolbarHeight),
            // 참고 사이트 WillPopScope 가 Deprecated 된 설명
            // https://velog.io/@jeongminji4490/Flutter-WillPopScope-Deprecated

            // WillPopScope > PopScope 으로 변경

            // 참고 사이트
            // https://seong9566.tistory.com/350
            child: PopScope(
              // canPop true 기본 뒤로가기 활성화
              // canPop false 기본 뒤로가기 비 활성화
              canPop: true,
              onPopInvoked: (value) {
                onBackTwo();
              },
              child: screenList.elementAt(currentIndex),
            ),
          ),
        ),
      ),

      floatingActionButton: isShowFab? currentIndex == 0 ? FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.lightGreen,
        onPressed: () {},
        child: const Icon(Icons.add_circle_outline, size: 40,)
      )
      : const SizedBox()
      : const SizedBox(),
      // 중앙 이동
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 하단 네비게이션바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        elevation: 0.0,
        backgroundColor: Colors.green,
        // 참고 사이트 https://stackoverflow.com/questions/49029966/how-to-change-bottomnavigationbaritem-icon-when-selected-flutter
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white,
        // 참고 사이트 https://sleepy-it.tistory.com/23
        showUnselectedLabels: true, // label 표시 여부 설정
        // 참고 사이트 https://velog.io/@sharveka_11/BottomNavigationBar
        type: BottomNavigationBarType.fixed, // BottomNavigationBarItem3개 이상시 클릭시 움직임없애기
        items: [
          BottomNavigationBarItem(
            icon: currentIndex == 0? const Icon(Icons.home) : const Icon(Icons.text_snippet),
            label: '커뮤니티',
          ),

          BottomNavigationBarItem(
            icon: currentIndex == 3? const Icon(Icons.person) : const Icon(Icons.perm_identity),
            label: '마이',
          ),
        ],
        onTap: (value){
          searchFocus.unfocus();
          setState(() {
            if(currentIndex == 0 || currentIndex == 2 || currentIndex == 3){
              //스크롤 젤위로 위치시키기
              controller.jumpTo(0);
            }
            currentIndex = value;
          });
        },
      ),
    );
  }
}

void toastView(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.black,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM
  );
}