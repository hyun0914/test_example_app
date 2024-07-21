import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'screen/address_search_screen.dart';
import 'screen/animated_splash_packages_screen.dart';
import 'screen/animated_widget_screen.dart';
import 'screen/app_life_cycle_screen.dart';
import 'screen/boxfit_screen.dart';
import 'screen/button_trigger_screen.dart';
import 'screen/cache_image_widget_screen.dart';
import 'screen/click_widget_screen.dart';
import 'screen/custom_clippers_screen.dart';
import 'screen/apps_device_info_screen.dart';
import 'screen/data_comparison_screen.dart';
import 'screen/dio_test_screen.dart';
import 'screen/hide_widget_screen.dart';
import 'screen/internal_storage_screen.dart';
import 'screen/introduction_packages_screen.dart';
import 'screen/list_wheel_scroll_view_screen.dart';
import 'screen/long_text_screen.dart';
import 'screen/package_widget01_screen.dart';
import 'screen/default_widget01_screen.dart';
import 'screen/date_related_screen.dart';
import 'screen/pdf_package_screen.dart';
import 'screen/print_screen.dart';
import 'screen/responsive_widgets_screen.dart';
import 'screen/tab_bar_screen.dart';
import 'screen/scaffold_screen.dart';
import 'screen/number_related_screen.dart';
import 'screen/pop_up_widget_screen.dart';
import 'screen/hero_screen.dart';
import 'screen/table_widget_screen.dart';
import 'screen/text_field_screen.dart';
import 'screen/web_view_package_screen.dart';
import 'screen/widget/default_scaffold.dart';

class SelectTest extends StatelessWidget {
  const SelectTest({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    GlobalKey tutorialKey = GlobalKey();
    GlobalKey tutorialKey2 = GlobalKey();
    GlobalKey tutorialKey3 = GlobalKey();

    dynamic targetFocusBasic({
      required dynamic identify,
      required GlobalKey keyTarget,
      ShapeLightFocus? shape,
      double? paddingFocus,
      required ContentAlign align,
      required EdgeInsets padding,
      required CrossAxisAlignment crossAxisAlignment,
      required List<Widget> children,
    }) {
      return TargetFocus(
        identify: identify,
        keyTarget: keyTarget,
        shape: shape ?? ShapeLightFocus.RRect,
        color: Colors.black26,
        enableOverlayTab: true,
        focusAnimationDuration: const Duration(milliseconds: 400),
        unFocusAnimationDuration: const Duration(milliseconds: 400),
        paddingFocus: paddingFocus,
        contents: [
          TargetContent(
            align: align,
            padding: padding,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              );
            },
          ),
        ],
      );
    }

    void showTutorial() {
      TutorialCoachMark(
        targets: [
          targetFocusBasic(
            identify: 'Target 1',
            keyTarget: tutorialKey,
            shape: ShapeLightFocus.Circle,
            paddingFocus: 1,
            align: ContentAlign.left,
            padding: const EdgeInsets.fromLTRB(160, 0, 0, 10),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Target 1 설명', style: TextStyle(fontSize: 16, color: Colors.white),)
            ],
          ),
          targetFocusBasic(
            identify: 'Target 2',
            keyTarget: tutorialKey2,
            shape: ShapeLightFocus.RRect,
            paddingFocus: 1,
            align: ContentAlign.top,
            padding: const EdgeInsets.fromLTRB(160, 0, 0, 10),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Target 2 설명', style: TextStyle(fontSize: 16, color: Colors.white),)
            ],
          ),
          targetFocusBasic(
            identify: 'Target 3',
            keyTarget: tutorialKey3,
            shape: ShapeLightFocus.RRect,
            paddingFocus: 1,
            align: ContentAlign.top,
            padding: const EdgeInsets.fromLTRB(160, 0, 0, 10),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Target 3 설명', style: TextStyle(fontSize: 16, color: Colors.white),)
            ],
          ),
        ],
        colorShadow: Colors.grey.shade200,
        onClickTarget: (target) {
          print('onClickTarget $target');
        },
        onClickTargetWithTapPosition: (target, tapDetails) {
          print('onClickTargetWithTapPosition\n$target\n$tapDetails');
          if(target.identify == 'Target 2') {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        },
        onClickOverlay: (target) {
          print('onClickOverlay $target');
          if(target.identify == 'Target 2') {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        },
        onSkip: () {
          print('onSkip');
          return true;
        },
        onFinish: () {
          print('onFinish');
        },
      ).show(context: context);
    }

    return DefaultScaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              // FormatException: It was not possible to obtain target position (Target 1).오류 발생
              // Future.delayed(const Duration(seconds: 5), showTutorial); 화면이 그려지기 전에 호출 해서 문제 발생
              // https://stackoverflow.com/questions/70270985/flutter-tutorialcoachmark-wrong-position
              onTap: () => showTutorial(),
              child: const Text('튜토리얼 시작', style: TextStyle(fontSize: 20),)
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: tutorialKey,
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
                keyValue: tutorialKey2,
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
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AppsDeviceInfoScreen())),
                testTile: '앱 및 기기 정보'
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
              textPushBtn(
                context: context,
                onPressed: () async {
                  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15)).then((value) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CacheImageWidgetScreen()));
                  });
                },
                testTile: '캐시 이미지 위젯'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PdfPackageScreen())),
                testTile: 'PDF 패키지'
              ),
              textPushBtn(
                keyValue: tutorialKey3,
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WebViewPackageScreen())),
                testTile: 'WebView 패키지'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const InternalStorageScreen())),
                testTile: '내부 저장'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AnimatedSplashPackageScreen())),
                testTile: 'animated_splash_screen 패키지'
              ),
              textPushBtn(
                context: context,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DataComparisonScreen())),
                testTile: '데이터 비교'
              ),
            ],
          ),
        )
      ),
    );
  }
}

Widget textPushBtn({
  GlobalKey? keyValue,
  required BuildContext context,
  required void Function() onPressed,
  required String testTile,
}) {
  return Center(
    key: keyValue,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(testTile)
      ),
    ),
  );
}