import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

class AppLifeCycleScreen extends StatefulWidget {
  const AppLifeCycleScreen({super.key});

  @override
  State<AppLifeCycleScreen> createState() => _AppLifeCycleScreenState();
}

class _AppLifeCycleScreenState extends State<AppLifeCycleScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // 참고 사이트
  // https://bb-library.tistory.com/215
  // https://parkjh7764.tistory.com/185
  // https://velog.io/@yellowtoast/Flutter-App-%EC%A0%84%EC%B2%B4%EC%9D%98-LifeCycle%EA%B3%BC-WidgetBindingObserver%EC%97%90-%EB%8C%80%ED%95%B4-%EC%95%8C%EC%95%84%EB%B3%B4%EC%9E%90
  // https://medium.com/@cody.yun/flutter-%EC%95%B1%EC%9D%98-%EB%9D%BC%EC%9D%B4%ED%94%84%EC%82%AC%EC%9D%B4%ED%81%B4-%EB%8B%A4%EB%A3%A8%EA%B8%B0-5a2aafbf7f4e

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      // 포그라운드 상태 - 앱이 화면에 다시 시작하는 경우, 최초 앱 실행때 X
      // 재개됨
      case AppLifecycleState.resumed:
        snackBarView(context: context, message: 'AppLifecycleState.resumed');
        break;

      // 앱이 비활성화 - (Android, iOS) 모두 전화 통화를 할 때 해당 상태
      // 비활성화
      case AppLifecycleState.inactive:
        snackBarView(context: context, message: 'AppLifecycleState.inactive');
        break;

      // 사용자가 홈버튼 등 으로 앱이 백그라운드 상태 - 사용자가 앱을 볼수 없는 상태
      // 일시 정지
      case AppLifecycleState.paused:
        snackBarView(context: context, message: 'AppLifecycleState.paused');
        break;

      // 플러터 엔진은 호스팅, 모든 뷰에서 분리된 상태, 뷰가 Navigator. pop에 의해 파괴된 상태
      // 분리됨
      case AppLifecycleState.detached:
        snackBarView(context: context, message: 'AppLifecycleState.detached');
        break;

      // 숨겨진
      case AppLifecycleState.hidden:
        snackBarView(context: context, message: 'AppLifecycleState.hidden');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold();
  }
}
