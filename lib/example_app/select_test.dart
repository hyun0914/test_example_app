import 'package:flutter/material.dart';

import 'screen/address_search_screen.dart';
import 'screen/animated_widget_screen.dart';
import 'screen/app_life_cycle_screen.dart';
import 'screen/boxfit_screen.dart';
import 'screen/button_trigger_screen.dart';
import 'screen/click_widget_screen.dart';
import 'screen/custom_clippers_screen.dart';
import 'screen/device_info_screen.dart';
import 'screen/dio_test_screen.dart';
import 'screen/hide_widget_screen.dart';
import 'screen/introduction_packages_screen.dart';
import 'screen/list_wheel_scroll_view_screen.dart';
import 'screen/long_text_screen.dart';
import 'screen/package_widget01_screen.dart';
import 'screen/default_widget01_screen.dart';
import 'screen/date_related_screen.dart';
import 'screen/print_screen.dart';
import 'screen/responsive_widgets_screen.dart';
import 'screen/tab_bar_screen.dart';
import 'screen/scaffold_screen.dart';
import 'screen/number_related_screen.dart';
import 'screen/pop_up_widget_screen.dart';
import 'screen/hero_screen.dart';
import 'screen/table_widget_screen.dart';
import 'screen/text_field_screen.dart';
import 'screen/widget/default_scaffold.dart';

class SelectTest extends StatelessWidget {
  const SelectTest({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return DefaultScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 참고 사이트
          // https://velog.io/@wannabeing/Flutter-ListView-%EC%8A%A4%ED%81%AC%EB%A1%A4-%EB%A7%A8-%EB%B0%91%EC%9C%BC%EB%A1%9C-%EA%B3%A0%EC%A0%95%ED%95%98%EA%B8%B0
          // https://velog.io/@jwjley/Flutter-%EC%8A%A4%ED%81%AC%EB%A1%A4-%EC%9C%84%EC%B9%98-%ED%8C%8C%EC%95%85%ED%95%98%EA%B8%B0
          // scroll.position.pixels 스크롤 위치 확인
          // scroll.position.maxScrollExtent 스크롤의 최대 높이
          // scroll.position.minScrollExtent 스크롤의 최소 높이
          if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            // 맨위로
            scrollController.jumpTo(0);
            // scrollController.jumpTo(scrollController.position.minScrollExtent);
          }
          else if(scrollController.position.pixels == scrollController.position.minScrollExtent) {
            // 맨 아래로
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        },
      ),
      body: SafeArea(
        // 앱바, 하단바 간격만큼 띄우고 나서 위젯 보이게 설정
        // top: kToolbarHeight 상단바
        // bottom: kToolbarHeight을 하면 하단바
        // margin: const EdgeInsets.only(bottom: kToolbarHeight),

        // 참고 사이트 flutter appbar height size get
        // https://stackoverflow.com/questions/50075945/how-to-get-appbar-height-in-flutter
        // 높이를 디바이스크기 만큼 지정 후 앱바 크기만큼 줄인다.
        // height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HeroScreen())),
                testTile: 'Hero'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BoxFitScreen())),
                testTile: 'Boxfilt'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PackageWidget01Screen())),
                testTile: '패키지 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DefaultWidget01Screen())),
                testTile: '기본 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DateRelatedScreen())),
                testTile: '날짜 관련'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TabBarScreen())),
                testTile: '탭바'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ScaffoldScreen())),
                testTile: 'Scaffold'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NumberRelatedScreen())),
                testTile: '숫자 관련'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PopUpWidgetScreen())),
                testTile: '팝업 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AppLifeCycleScreen())),
                testTile: '앱 라이프 사이클'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TextFieldScreen())),
                testTile: '텍스트 필드'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DioTestScreen())),
                testTile: 'dio'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ButtonTriggerScreen())),
                testTile: '버튼 트리거'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HideWidgetsScreen())),
                testTile: '위젯 숨기기'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TableWidgetScreen())),
                testTile: '테이블 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PrintScreen())),
                testTile: 'print 관련'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DeviceInfoScreen())),
                testTile: '앱 정보'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ResponsiveWidgetsScreen())),
                testTile: '반응형 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LongTextScreen())),
                testTile: '긴 텍스트'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AnimatedWidgetScreen())),
                testTile: '애너메이티드 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ClickWidgetScreen())),
                testTile: '클릭 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddressSearchScreen())),
                testTile: '주소 검색'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const IntroductionPackagesScreen())),
                testTile: 'introduction_screen 패키지'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListWheelScrollViewScreen())),
                testTile: 'ListWheelScrollView 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CustomClippersScreen())),
                testTile: 'custom_clippers 패키지'
              ),
            ],
          ),
        )
      ),
    );
  }
}

Widget textPushBtn({
  required final BuildContext context,
  required final void Function() onPressed,
  required final String testTile,
}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(testTile)
      ),
    ),
  );
}