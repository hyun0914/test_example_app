import 'package:flutter/material.dart';

class TabBarFirstView extends StatefulWidget {
  const TabBarFirstView({super.key});

  @override
  State<TabBarFirstView> createState() => _TabBarFirstViewState();
}

class _TabBarFirstViewState extends State<TabBarFirstView> with  SingleTickerProviderStateMixin {
  // 참고 사이트 https://jinhan38.com/149
  late AnimationController animationController;

  // addListener BottomSheet가 움직일 때 마다 호출
  // animationController.value BottomSheet의 애니메이션 진척률
  // animationController.status BottomSheet의 애니메이션 상태 값 알 수 있다.
  // (AnimationStatus에는 forward, completed , reverse, dismissed 4가지 타입)
  // duration BottomSheet의 올라오는 속도
  // reverseDuration BottomSheet의 내려가는 속도

  @override
  void initState() {
    animationController = BottomSheet.createAnimationController(this);
    animationController..addListener(() {
      print('---- ${animationController.value} ${animationController.status}');
    })
    ..duration = const Duration(milliseconds: 400)
    ..reverseDuration = const Duration(milliseconds: 400);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 앱 실행시 showModalBottomSheet 호출 하는 법
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   showBottomSheet(context);
    // });
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => showSheet(context),
            child: const Text('showModalBottomSheet')
          ),
        ],
      ),
    );
  }

  // 참고 사이트
// flutter showModalBottomSheet height
// https://stackoverflow.com/questions/53311553/how-to-set-showmodalbottomsheet-to-full-height

// Wrap
// https://velog.io/@qkrtnfks128/showModalBottomSheet-%EC%9E%90%EC%8B%9D-%EB%86%92%EC%9D%B4%EB%A7%8C%ED%81%BC-height

// flutter showmodalbottomsheet 모서리 둥글게
// https://cyj893.github.io/flutter/Flutter8/

// flutter showmodalbottomsheet textfield scroll
// https://www.youtube.com/watch?v=VLQdvUS2zeY

// TextField 넣었을때 TextField클릭 시 키보드따라 화면 위로 이동 되게 할려면
// isScrollControlled: true, padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),

// 스크롤 하고 싶으면 ListView, SingleChildScrollView 등 을 상위 widget 으로 한다.

  Future showSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        barrierColor: Colors.greenAccent, // showModalBottomSheet 외의 영역 색상
        backgroundColor: Colors.green, // showModalBottomSheet 배경색상
        enableDrag: true, // false 설정 시 showModalBottomSheet를 드래그해서 닫기 비활성화됨
        isScrollControlled: false, // bottomSheet의 높이를 full로 설정 여부 (기본 false)
        isDismissible: true, // showModalBottomSheet 외 영역 클릭시 닫히지 않게 설정 여부
        useSafeArea: false, // 상태바 영역 까지 올라게 할지 말지 설정
        transitionAnimationController: animationController,
        // 모서리 둥글게 하기
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        builder: (context) {
          // 높이의 조절을 내용물에 맞게 자동으로 조절한다.
          return Container(
            padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: '입력해주세요',
                  ),
                ),
                Container(
                  width: 500,
                  height: 500,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  color: Colors.lightGreen,
                ),
              ],
            ),
          );
        }
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))
      ),
      builder: (BuildContext context) {
        return Container(
          height: 230,
          decoration: const BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('닫기'))),
                  Expanded(child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('닫기'))),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}