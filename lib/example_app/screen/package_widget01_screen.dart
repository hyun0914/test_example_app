import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:card_slider/card_slider.dart';
import 'package:d_chart/d_chart.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:badges/badges.dart' as badges;
import 'package:focus_detector/focus_detector.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:hold_down_button/hold_down_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pager/pager.dart';
import 'package:scroll_screenshot/scroll_screenshot.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tab_container/tab_container.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timelines/timelines.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'widget/default_scaffold.dart';
import 'widget/snack_bar_view.dart';

// 참고 사이트 https://velog.io/@tmdgks2222/Flutter-intl
// '###,###,###', '###,###' 결과 값은 같다
var price = NumberFormat('###,###,###');
PageController controller = PageController();

List<Color> valuesDataColors = [
  const Color.fromRGBO(30, 133, 237, 1),
  const Color.fromRGBO(139, 74, 244, 1),
  const Color.fromRGBO(251, 180, 43, 1),
  const Color.fromRGBO(17, 159, 111, 1),
];

List<Widget> valuesWidget = [];

List<Color> colorsData = [
  const Color(0xfff29f05),
  const Color(0xfff27052),
  const Color(0xffbfa68f),
  const Color(0xff04bf68),
  const Color(0xff5068f2),
  const Color(0xff84a9cd),
  const Color(0xffb8e4dc),
  const Color(0xff9ed2ba),
  const Color(0xffa0ca68),
  const Color(0xff6a9951),
  const Color(0xff4a696c),
  const Color(0xff41545b),
];

List<Color> colors = [];
List<Widget> children = [];
List<Widget> tabs = [];

List<String> dropdownList = ['텍스트1', '텍스트2', '텍스트3', '텍스트4'];

GlobalKey visibilityDetectorKey = GlobalKey();

class PackageWidget01Screen extends StatelessWidget {
  const PackageWidget01Screen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();
    GlobalKey scrollableGlobalKey = GlobalKey();
    valuesWidget.clear();

    for (int i = 0; i < valuesDataColors.length; i++) {
      valuesWidget.add(
        Container(
          padding: const EdgeInsets.fromLTRB(25, 25, 23, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: valuesDataColors[i],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(6.5, 3, 6.5, 3),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Text('0${i+1}', style: Theme.of(context).textTheme.displayMedium!.copyWith(color: valuesDataColors[i]),),
              ),
              const SizedBox(height: 16,),
              Expanded(
                child: Text(
                  '테스트 card_slider $i',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget timePickerSpinner() {
      return TimePickerSpinner(
        is24HourMode: false,
        normalTextStyle: const TextStyle(
          fontSize: 24,
          color: Colors.greenAccent
        ),
        highlightedTextStyle: const TextStyle(
          fontSize: 24,
          color: Colors.limeAccent
        ),
        spacing: 50,
        itemHeight: 80,
        isForce2Digits: true,
        onTimeChange: (time) {
          print(time);
        },
      );
    }

    colors.clear();
    children.clear();
    tabs.clear();

    for(int i = 0; i < 4; i++) {
      colors.add(colorsData[i]);
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text('tab_container text$i',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: const Color.fromRGBO(255, 255, 255, 1))
              )
            ),
          ],
        ),
      );

      tabs.add(
        Image.asset('assets/images/hen.png', width: 20, height: 20,)
      );
    }

    // 캡쳐 참고 사이트 https://deque.tistory.com/135
    // 스크롤 화면 캡쳐
    Future<void> saveScreenshot() async {
      await ScrollScreenshot.captureAndSaveScreenshot(globalKey).then((base64String) {
        final Uint8List unit8List = const Base64Decoder().convert(base64String!);
        showDialog(
          context: context,
          builder: (context) {
            return SingleChildScrollView(child: Image.memory(unit8List));
          }
        );
      });
    }

    // 화면 캡쳐 후 갤러리 저장
    Future<void> takePhoto() async {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        print(result);
      }
    }

    // 스크롤 화면 캡쳐 후 갤러리 저장
    Future<void> saveScroll() async {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        print(result);
      }
    }
    // 위젯이 화면에 나타나거나 사라질 때 마다 체크
    return FocusDetector(
      onFocusLost: () {
        print('onFocusLost');
      },
      onFocusGained: () {
        print('onFocusGained');
      },
      onVisibilityLost: () {
        print('onVisibilityLost');
      },
      onVisibilityGained: () {
        print('onVisibilityGained');
      },
      onForegroundLost: () {
        print('onForegroundLost');
      },
      onForegroundGained: () {
        print('onForegroundGained');
      },
      child: DefaultScaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // saveScreenshot();
            // takePhoto();
            // saveScroll();
      
            // 참고 사이트 (특정 위치로 이동(스크롤))
            // https://terry1213.com/flutter/flutter-move-scroll-to-specific-widget/
            Scrollable.ensureVisible(
              scrollableGlobalKey.currentContext!,
              duration: const Duration(seconds: 1)
            );
          },
        ),
        body: Container(
          color: const Color.fromRGBO(1, 98, 65, 1),
          child: SafeArea(
            // 화면크기에 맞게 또는 넘어가기 내용물이 없으면 중앙 정렬? 처럼 되셔 위에 간격이 생긴다.
            // 해결법은 Column => Expanded => singlechildscrollview 으로 하면 해결
            child: SingleChildScrollView(
              child: RepaintBoundary(
                key: globalKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    // 위젯이 화면에 나타나거나 사라질 때 마다 체크
                    VisibilityDetector(
                      key: visibilityDetectorKey,
                      onVisibilityChanged: (VisibilityInfo info) {
                        // 참고 사이트
                        // https://paran21.tistory.com/214
                        // info.visibleFraction == 1.0 화면에 보임
                        // info.visibleFraction == 0.0 화면에 안보임
                        if(info.visibleFraction == 1.0) {
                          snackBarView(context: context, message: 'visibleFraction == 1.0');
                        }
                        else {
                          snackBarView(context: context, message: 'visibleFraction == 0.0');
                        }
                      },
                      child: SizedBox(
                        width: 200,
                        height: 70,
                        child: Shimmer.fromColors(
                          baseColor: Colors.green,
                          highlightColor: Colors.amberAccent,
                          child: const Text(
                            '로딩 중',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 참고 사이트
                    // https://velog.io/@tygerhwang/FLUTTER-Shimmer
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child:  Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),

                    // 참고 사이트
                    // https://kimhyeongi.tistory.com/61
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white
                          ),
                          child: const SpinKitRotatingCircle(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white
                          ),
                          child: const SpinKitRotatingPlain(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white
                          ),
                          child: const SpinKitDoubleBounce(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: const SpinKitRing(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: const SpinKitCircle(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: const SpinKitWave(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: const SpinKitPouringHourGlassRefined(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white
                          ),
                          child: const SpinKitPulsingGrid(
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    CupertinoPageScaffold(
                      child: TimerCountdown(
                        format: CountDownTimerFormat.daysHoursMinutesSeconds,
                        endTime: DateTime.now().add(
                          const Duration(
                            days: 5,
                            hours: 14,
                            minutes: 27,
                            seconds: 34,
                          ),
                        ),
                        onEnd: () {
                          print("Timer finished");
                        },
                      ),
                    ),
                    CupertinoPageScaffold(
                      child: TimerCountdown(
                        format: CountDownTimerFormat.daysHoursMinutes,
                        enableDescriptions: false,
                        endTime: DateTime.now().add(
                          const Duration(
                            days: 5,
                            hours: 14,
                            minutes: 27,
                            seconds: 34,
                          ),
                        ),
                        onEnd: () {
                          print("Timer finished");
                        },
                      ),
                    ),
                    CupertinoPageScaffold(
                      child: TimerCountdown(
                        format: CountDownTimerFormat.hoursOnly,
                        enableDescriptions: true,
                        endTime: DateTime.now().add(
                          const Duration(
                            days: 5,
                            hours: 14,
                            minutes: 27,
                            seconds: 34,
                          ),
                        ),
                        onEnd: () {
                          print("Timer finished");
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: const SlideCountdown(
                        duration: Duration(days: 2),
                        countUp: false,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const SlideCountdownSeparated(
                        duration: Duration(days: 2),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: const SlideCountdown(
                        duration: Duration(days: 2),
                        separatorType: SeparatorType.title,
                        slideDirection: SlideDirection.up,
                      ),
                    ),


                    SizedBox(
                      width: 400,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField2(
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6))
                            )
                          ),
                          hint: const Text('선택'),
                          selectedItemBuilder: (BuildContext context) {
                            return dropdownList.map((String item) {
                              return Text(
                                item,
                                style: const TextStyle(color: Colors.limeAccent),
                              );
                            }).toList();
                          },
                          items: dropdownList.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(color: Colors.orangeAccent),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ),

                    const SizedBox(height: 20,),
                    FlutterSlider(
                      values: const [40, 60],
                      rangeSlider: true,
                      max: 80,
                      min: 0,
                      // axis: Axis.vertical, horizontal, vertical,
                      // rtl: true, // true 하면 화살표 < , false 하면 >
                      onDragging: (handlerIndex, lowerValue, upperValue) {

                      },
                    ),

                    const SizedBox(height: 20,),
                    NumberPaginator(
                      numberPages: 4,
                      config: NumberPaginatorUIConfig(
                        buttonSelectedForegroundColor: Colors.limeAccent,
                        buttonUnselectedForegroundColor: Colors.white,
                        buttonUnselectedBackgroundColor: Colors.grey,
                        buttonSelectedBackgroundColor: Colors.blueGrey,
                        buttonShape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPageChange: (int index) { },
                    ),
                    const SizedBox(height: 8,),
                    Pager(
                      currentPage: 1,
                      totalPages: 5,
                      onPageChanged: (page) {},
                    ),
                    const SizedBox(height: 20,),
      
                    Container(
                      width: 400,
                      height: 200,
                      padding: const EdgeInsets.only(top: 6),
                      child: TabContainer(
                        tabEdge: TabEdge.right,
                        colors: colors,
                        tabs: tabs,
                        children: children,
                      ),
                    ),
      
                    Container(
                      color: Colors.white,
                      child: TableCalendar(
                        focusedDay: DateTime.now(),
                        firstDay: DateTime(2021),
                        lastDay: DateTime(2025),
                        headerStyle: const HeaderStyle(formatButtonVisible: false),
                        calendarFormat: CalendarFormat.month,
                        // 9월달에서 8월달의 일을 클릭시 8월로 이동하게 하는법
                        pageJumpingEnabled: true,
                        // 달력을 항상 6주로 표시 할지 말지 , 기본은 false
                        // sixWeekMonthsEnforced: true,
                      ),
                    ),
                    timePickerSpinner(),
                    CardSlider(
                      cards: valuesWidget,
                      bottomOffset: .0005,
                      itemDotWidth: 14, // 밑점 넓이
                      cardHeight: 0.95,
                      itemDotOffset: 0.5, // 밑점 위치
                      itemDot: (itemDotWidth) { // 밑점 위젯생성
                        return Container(
                          margin: const EdgeInsets.all(5),
                          width: 8 + itemDotWidth,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          )
                        );
                      },
                    ),
      
                    TimelineTile(
                      oppositeContents: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('opposite\nContents'),
                      ),
                      contents: Card(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('contents'),
                        ),
                      ),
                      node: const TimelineNode(
                        indicator: DotIndicator(),
                        startConnector: SolidLineConnector(),
                        endConnector: SolidLineConnector(),
                      ),
                    ),
      
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 4,
                        axisDirection: Axis.horizontal, // 방향 설정 (vertical || horizontal)
                        effect: const SlideEffect(
                          spacing: 8.0, // 점 사이의 수평 공간
                          radius: 16.0, // 한개의 도트 반경
                          dotWidth: 20.0, // 도트 폭
                          dotHeight: 20.0, // 도트 높이
                          dotColor: Colors.grey, // 비활성 도트 색상
                          activeDotColor: Colors.indigo, // 활성 도트 색상
                          paintStyle: PaintingStyle.stroke, // 비활성 도트 페인트 스타일 (fill|stroke)
                          strokeWidth: 1.5, // PaintStyle.fill인 경우 이는 무시
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
      
                    HoldDownButton(
                      onHoldDown: holdDownEvent,
                      child: const Text('Text'),
                    ),
      
                    HoldDownButton(
                      onHoldDown: holdDownEvent,
                      longWait: const Duration(milliseconds: 1000),
                      middleWait: const Duration(milliseconds: 600),
                      minWait: const Duration(milliseconds: 300),
                      child: const ElevatedButton(
                        onPressed: holdDownEvent,
                        child: Text('ElevatedButton'),
                      ),
                    ),
      
                    HoldDownButton(
                      onHoldDown: holdDownEvent,
                      longWait: const Duration(milliseconds: 2000),
                      middleWait: const Duration(milliseconds: 1500),
                      minWait: const Duration(milliseconds: 1200),
                      holdWait: const Duration(milliseconds: 1000),
                      child: const TextButton(
                        onPressed: holdDownEvent,
                        child: Text('TextButton', style: TextStyle(color: Colors.orange),),
                      ),
                    ),
      
                    HoldDownButton(
                      onHoldDown: holdDownEvent,
                      longWait: const Duration(milliseconds: 100),
                      middleWait: const Duration(milliseconds: 100),
                      minWait: const Duration(milliseconds: 100),
                      holdWait: const Duration(milliseconds: 100),
                      child: InkWell(
                        onTap: holdDownEvent,
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.blue,
                          child: const Center(
                            child: Text('Ink & InkWell'),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                      child: Text('${price.format(10000)}원'),
                    ),
      
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: ElevatedButton(
                        onPressed: () => showToast(msg: '테스트'),
                        child: const Text('토스트메세지 테스트')
                      ),
                    ),
      
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: () => actionSheet(context: context),
                        child: const Text('Adaptive action sheet 테스트')
                      ),
                    ),
      
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: const badges.Badge(
                        badgeContent: Text('3'),
                        child: Icon(Icons.settings),
                      ),
                    ),
      
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('만족도', style: TextStyle(fontSize: 30, color: Colors.white),),
                          RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.green,),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),

                    AnimatedRadialGauge(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInBack,
                      radius: 80,
                      // 글자 표시
                      builder: (context, _, value) {
                        return  RadialGaugeLabel(
                          value: value,
                          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                        );
                      },
                      value: 30,
                      axis: GaugeAxis(
                        min: 0,
                        max: 100,
                        degrees: 180,
                        style: GaugeAxisStyle(
                          thickness: 10,
                          background: Colors.grey.shade400,
                          segmentSpacing: 2,
                        ),
                        // pointer: null, 로 설정하면 pointer 표시 안됨
                        pointer: const GaugePointer.triangle(
                          borderRadius: 16 * 0.125,
                          width: 20,
                          height: 20,
                          color: Color(0xFF193663),
                        ),
                        progressBar: const GaugeProgressBar.rounded(
                          color: Color(0xFFB4C2F8),
                        ),
                      ),
                    ),

                    AspectRatio(
                      key: scrollableGlobalKey,
                      aspectRatio: 1.4,
                      child: DChartPieO(
                        data: [
                          OrdinalData(domain: 'sales', measure: 70, color: const Color.fromRGBO(17, 159, 111, 1)),
                          OrdinalData(domain: 'default', measure: 20, color: const Color.fromRGBO(247, 90, 93, 1)),
                          OrdinalData(domain: 'purchase', measure: 10, color: const Color.fromRGBO(240, 240, 240, 1)),
                        ],
                        configRenderPie: const ConfigRenderPie(
                          arcWidth: 20,
                          arcLength: 7 / 5 * 3.14,
                          startAngle: 4 / 5 * 3.14,
                        ),
                      ),
                    ),
      
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 10,
                              // 좌우 반전 - flutter 위젯 좌우 반전
                              // import 'dart:math' as math;
                              // double degrees = 180;
                              // double radians = degrees * math.pi / 180;
                              // 참고 사이트
                              // https://happyguy81.tistory.com/145
                              // https://stcodelab.com/entry/Flutter-%EC%9C%84%EC%A0%AF-%ED%9A%8C%EC%A0%84-RotatedBox-Transformrotate-AnimatedBuilder
                              child: Transform.rotate(
                                angle: 180 * math.pi / 180,
                                child: const DChartSingleBar(
                                  radius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)
                                  ),
                                  foregroundColor: Color.fromRGBO(17, 159, 111, 1),
                                  backgroundColor: Color.fromRGBO(219, 219, 219, 1),
                                  value: 80,
                                  max: 100,
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 10,
                              child: DChartSingleBar(
                                radius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                                ),
                                foregroundColor: Color.fromRGBO(247, 90, 93, 1),
                                backgroundColor: Color.fromRGBO(219, 219, 219, 1),
                                value: 20,
                                max: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
      
                    // 참고 사이트 https://velog.io/@flxh4894/Flutter-Widget-%EC%A2%8C%EC%9A%B0-%EB%B0%98%EC%A0%84
                    Column(
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi), // 좌우 반전
                          child: Row(
                            children: [
                              Container(
                                color: Colors.yellow,
                                width: 50,
                                height: 50,
                              ),
                              Container(
                                color: Colors.grey,
                                width: 50,
                                height: 50,
                                child: const Text('반전', style: TextStyle(fontSize: 18),),
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationX(math.pi), // 상하 반전
                          child: Container(
                            color: Colors.yellow,
                            width: 50,
                            height: 50,
                            child: const Text('반전', style: TextStyle(fontSize: 18),),
                          ),
                        ),
                      ],
                    ),
      
                    FlutterCarousel(
                      options: FlutterCarouselOptions(
                        height: 400.0,
                        showIndicator: true,
                        slideIndicator: CircularSlideIndicator(),
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        enableInfiniteScroll: true,
                        // 위젯을 fill로 보이게 설정
                        // viewportFraction: 1.0,
                        // padEnds: false, // 왼쪽부분 표시x 오른쪽부분 표시o
                      ),
                      items: [1,2,3,4].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: const BoxDecoration(color: Colors.green),
                              child: Text('text $i', style: const TextStyle(fontSize: 16.0),)
                            );
                          },
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void holdDownEvent() {
  print('hold_down_button 클릭');
}

// 참고 사이트 https://velog.io/@meibinlee/Flutter-Toast-message
void showToast({
  required String msg,
}) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.green,
    toastLength: Toast.LENGTH_LONG, // 토스트 뜨는 시간 얼마나 길게 할 지 (Android)
    timeInSecForIosWeb: 1, //  // 토스트 뜨는 시간 얼마나 길게 할 지 (iOS & Web)
    gravity: ToastGravity.TOP,
  );
}

void actionSheet({
  required BuildContext context
}) {
  showAdaptiveActionSheet(
    context: context,
    actions: <BottomSheetAction>[
      BottomSheetAction(title: const Text('수정하기'), onPressed: (context){}),
      BottomSheetAction(title: const Text('삭제하기'), onPressed: (context){}),
    ],
    cancelAction: CancelAction(title: const Text('취소')),
  );
}