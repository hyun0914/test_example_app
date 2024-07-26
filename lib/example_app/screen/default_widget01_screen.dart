import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widget/absorb_pointer_test.dart';
import 'widget/drop_down_but.dart';
import 'widget/ignore_pointer_test.dart';
import 'widget/progress_indicator_view.dart';
import 'widget/shake_icon.dart';

// 위젯 화면 fill로 하는법
// Row 위젯으로 감싼 후 child 위젯을 Expanded 위젯으로 감싼다
// Column 위젯으로 감싼 후 crossAxisAlignment: CrossAxisAlignment.stretch를 준다.
// width: double.infinity,
// height: double.infinity,
// width: MediaQuery.of(context).size.width,


// 색상 지정법
// 참고 사이트 https://bigstar-vlog.tistory.com/68
// color: Colors.green;
// color: Color.fromARGB();
// color: Color.fromRGBO();
// color: Color(0xff123456);

// 참고 사이트 https://sikk.tistory.com/19
final textController = TextEditingController(text: '초기값텍스트');

Offset offset = Offset.zero;

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DefaultWidget01Screen extends StatelessWidget {
  const DefaultWidget01Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();
    final GlobalKey<TooltipState> tooltipKey2 = GlobalKey<TooltipState>();
    var primaryScrollController = PrimaryScrollController.of(context);
    bool switchValue = true;
    double barValue = 280 *(40 / 100);
    return Scaffold(
      extendBody: true,
      // 참고 사이트 https://stackoverflow.com/questions/69001896/how-to-hide-floatingactionbutton-under-keyboard-and-not-textformfield-in-flutter
      // floatingActionButton 키보드 뒤로 가는 설정 false 이면 뒤로간다
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(onPressed: () {
        // 참고 사이트
        // https://velog.io/@sangh518/flutter-scroll-to-top
        // https://dev-nam.tistory.com/25 ScrollController 방법(스크롤 최상단으로 이동)
        primaryScrollController.jumpTo(0);
      },),
      // 참고 영상 https://www.youtube.com/watch?v=MW-KVmnXuiE
      // BottomAppBar 위젯 shape: CircularNotchedRectangle(), notchMargin: 7, 추가 하면 notched가 된다.
      // 뒤에 부분 표시할려면 Scaffold 위젯의 extendBody: true, 추가한다.
      // 중앙 이동
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton 키보드 뒤로 숨기는 방법
        //MediaQuery.of(context).viewInsets.bottom != 0 ? null :
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ShakeIcon(
              shakeMode: ShakeEnum.awhile,
              shakeWidth: 3,
              duration: 1000,
              child: Icon(Icons.access_alarms),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.home),
            Icon(Icons.access_alarms),
            Icon(Icons.edit),
          ],
        )
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Scrollbar(
            child: ScrollConfiguration(
              // 참고 사이트
              // https://terry1213.com/flutter/flutter-android-listview-overscroll-effect
              // https://changjoopark.medium.com/flutter-%EC%8A%A4%ED%81%AC%EB%A1%A4-%ED%9A%A8%EA%B3%BC%EB%A5%BC-%EC%97%86%EC%95%A0%EB%8A%94-%EB%B0%A9%EB%B2%95-ad196b7e7552
              behavior: NoGlowScrollBehavior(),
              //behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView(
                // 참고 사이트
                // https://velog.io/@gunwng123/Scrollbar-bouncing-%EB%A7%89%EA%B8%B0
                // https://abhishekdoshi26.medium.com/scrollphysics-in-flutter-9979008e861f
                // |
                // physics: const BouncingScrollPhysics(), // ios 기본 설정값
              
                // https://yihoeyiho.tistory.com/m/63
                // physics: const NeverScrollableScrollPhysics(), // 스크롤 x
                // scrollDirection: Axis.horizontal, 스크롤 방향 설정
                controller: primaryScrollController,
                children: [
                  const ProgressIndicatorView(),

                  Theme(
                    // Material3 적용, 미 적용 으로 하는 법
                    data: ThemeData(useMaterial3: true),
                    child: Switch(
                      value: switchValue,
                      activeTrackColor: const Color.fromRGBO(0, 129, 85, 1),
                      onChanged: (value) {
                        switchValue = value;
                      }
                    ),
                  ),

                  // 크기 조절
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      activeColor: const Color.fromRGBO(0, 129, 85, 1),
                      value: switchValue,
                      onChanged: (value) {
                    
                      },
                    ),
                  ),

                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 280,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: barValue,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // 참고 사이트
                  // https://wondev.tistory.com/104
                  const Text('Container-child-이미지 사이즈 원하는대로 하는법'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          color: Colors.lime,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Image.asset('assets/images/dog.png', width: 100, height: 100,),
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          color: Colors.lime,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(child: Image.asset('assets/images/dog.png', width: 100, height: 100,)),
                      ),
                    ],
                  ),

                  // 참고 사이트
                  // https://eunjin3786.tistory.com/421
                  // https://iosroid.tistory.com/36
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: '텍스트', style: TextStyle(color: Colors.brown)),
                        TextSpan(text: '텍스트10', style: TextStyle(color: Colors.indigo, fontSize: 20)),
                        TextSpan(text: '각각 스타일 적용', style: TextStyle(color: Colors.green)),
                      ]
                    )
                  ),

                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '텍스트', style: TextStyle(color: Colors.brown)),
                        TextSpan(text: '텍스트10', style: TextStyle(color: Colors.indigo, fontSize: 20)),
                        TextSpan(text: '각각 스타일 적용', style: TextStyle(color: Colors.green)),
                      ]
                    )
                  ),

                  const DropDownBut(),

                  // 참고 사이트 https://velog.io/@haram2/Tooltip-class
                  GestureDetector(
                    onTap: () => tooltipKey.currentState?.ensureTooltipVisible(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Tooltip(
                        key: tooltipKey,
                        message: 'Tooltip 메세지 입니다.',
                        triggerMode: TooltipTriggerMode.manual,
                        showDuration: const Duration(seconds: 1),
                        height: 40,
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        textStyle: const TextStyle(fontSize: 24,),
                        child: const Text('Tooltip 테스트'),
                      ),
                    ),
                  ),

                  Tooltip(
                    key: tooltipKey2,
                    message: 'Tooltip 메세지 입니다2.',
                    preferBelow: false,
                    triggerMode: TooltipTriggerMode.tap,
                    showDuration: const Duration(seconds: 1),
                    height: 40,
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    textStyle: const TextStyle(fontSize: 24,),
                    child: const Text('Tooltip 테스트2'),
                  ),

                  // 텍스트에 Gradient 색상 넣기
                  // 참고 사이트
                  // https://stackoverflow.com/questions/51686868/gradient-text-in-flutter
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.orange
                        ]
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height),),
                      child: const Text('Gradient 텍스트', style: TextStyle(color: Colors.white, fontSize: 24),),
                    ),
                  ),

                  // 참고 사이트
                  // https://bangu4.tistory.com/339
                  const Chip(
                    labelPadding: EdgeInsets.all(4.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.lightGreenAccent,
                      child: Text('12'),
                    ),
                    label: Text('Chip'),
                    backgroundColor: Colors.amberAccent,
                    elevation: 12.0,
                    shadowColor: Colors.red,
                    padding: EdgeInsets.all(10.0),
                  ),
              
                  // 버튼 비활성화 방법
                  // 참고 사이트
                  // https://velog.io/@sht-3756/Flutter-%ED%81%B4%EB%A6%AD%EC%9D%84-%EB%B0%A9%EC%A7%80%ED%95%98%EB%8A%94-%EC%9C%84%EC%A0%AF
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const IgnorePointerExample(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const AbsorbPointerExample()
                  ),
              
                  // 비동기로 하는법 onTap: () async { await Clipboard.setData(ClipboardData(text: "비동기 글자 복사")); },
                  // 참고 사이트
                  // https://velog.io/@tororae/Flutter-%ED%81%B4%EB%A6%BD%EB%B3%B4%EB%93%9CClipBoard-%EC%97%90-%EA%B8%80-%EB%B3%B5%EC%82%AC%ED%95%98%EA%B8%B0
                  GestureDetector(
                    onTap: () => Clipboard.setData(const ClipboardData(text: '텍스트 복사 하기')),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        color: Colors.lightGreen,
                        child: const Text('글자 복사하기', style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
              
                  // 참고 사이트 expansiontile flutter line delete
                  // https://stackoverflow.com/questions/64123839/flutter-remove-border-expansion-tile
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: const ExpansionTile(
                      initiallyExpanded: false,
                      tilePadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      childrenPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      collapsedBackgroundColor: Colors.green,
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      collapsedIconColor: Color.fromRGBO(51, 51, 51, 1),
                      iconColor: Color.fromRGBO(51, 51, 51, 1),
                      title: Text('텍스트 ...'),
                      children: [
                        Text('텍스트........')
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
              
                  // 정렬 종류
                  // topLeft
                  // topCenter
                  // topRight
                  // centerLeft
                  // center
                  // centerRight
                  // bottomLeft
                  // bottomCenter
                  // bottomRight
                  // 참고 사이트 https://naman-develop.tistory.com/8
                  const Align(alignment: Alignment.center, child: Text('중앙 정렬')),
              
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 149,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              // 그림자 설정
                              // color 그림자 색상
                              // blurRadius 그림자 효과를 선명도(0일 수록 그림자선이 선명해진다)
                              // spreadRadius 그림자효과의 반경 설정(값이 높을 수록 넓어진다)
                              // offset x,y의 offset값으로 x 값이 커질수록 오른쪽으로 y값이 커질수록 아래로 이동하여 표시된다
                              // 참고 사이트 https://gloria94.tistory.com/44
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                spreadRadius: 0,
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              )
                            ],
                            // gradient 종류
                            // LinearGradient, RadialGradient, SweepGradient
                            // 참고 사이트 https://dulki.tistory.com/308
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(255, 216, 67, 1),
                                Color.fromRGBO(238, 175, 11, 1),
                              ],
                            )
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          width: 140,
                          height: 149,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
                                spreadRadius: 0,
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              )
                            ],
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(255, 163, 77, 1),
                                Color.fromRGBO(238, 132, 34, 1),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(
                    height: 300,
                    child: StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(50.0),
                                        child: AnimatedSlide(
                                          offset: offset,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                          child: const FlutterLogo(size: 50.0),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Text('Y'),
                                        Expanded(
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Slider(
                                              min: -5.0,
                                              max: 5.0,
                                              value: offset.dy,
                                              onChanged: (double value) {
                                                setState(() {
                                                  offset = Offset(offset.dx, value);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text('X'),
                                  Expanded(
                                    child: Slider(
                                      min: -5.0,
                                      max: 5.0,
                                      value: offset.dx,
                                      onChanged: (double value) {
                                        setState(() {
                                          offset = Offset(value, offset.dy);
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 48.0),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              
                  Image.asset('assets/images/icicles1280.jpg', width: 200, height: 170,),
              
                  // flutter container background image 참고 사이트
                  // https://sleepy-it.tistory.com/21
                  // https://blog.terry1213.com/flutter/flutter-how-to-set-background-image
                  // https://www.flutterbeads.com/set-background-image-in-flutter/
                  Container(
                    width: 200,
                    height: 170,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        // container background image network(네트워크)
                        // image: DecorationImage(image: NetworkImage('')),
                        // 참고 사이트
                        // https://stackoverflow.com/questions/50877388/flutter-use-networkimage-as-background
                        // container background image memory(base64)
                        // image: DecorationImage(image: MemoryImage()),
                        // 참고 사이트
                        // https://stackoverflow.com/questions/68858165/how-to-use-a-picked-image-as-background-image-in-flutter
                        image: AssetImage('assets/images/icicles1280.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Text('이미지 배경', style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                  const SizedBox(height: 20,),
              
                  // 구분선 위젯
                  // 참고 사이트 https://devuryu.tistory.com/372
                  const Divider(thickness: 1, height: 1, color: Colors.green,),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 200, // 높이값을 지정해야함
                        child: VerticalDivider(thickness: 1, width: 4, indent: 20, endIndent: 0, color: Colors.green,)
                      ),
                      Container(
                        width: 100,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
              
                  // ExpansionTile 위젯을 펼쳤을 때 위아래에 줄이 있다.
                  // Theme(
                  //   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  //   child: ExpansionTile()
                  // ),
                  // 이렇게 하면 없어진다.
                  // 참고 사이트 (flutter expansiontile no border)
                  // https://stackoverflow.com/questions/64123839/flutter-remove-border-expansion-tile
              
                  // ExpansionTile위젯에 모서리를 둥글게 하는법
                  // ClipRRect, Container 위젯으로 감싼후 borderRadius를 지정한다.
                  // ClipRRect(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  //   child: ExpansionTile(),
                  // ),
                  // 참고 사이트(expansiontile border radius flutter)
                  // https://stackoverflow.com/questions/65331151/how-to-apply-rounded-borders-to-expanded-expansiontile-in-flutter
                  const ExpansionTile(
                    initiallyExpanded: true, // 처음 화면들어왔을때 펼친상태로 할지 말지 설정
                    collapsedBackgroundColor: Colors.amber, // 닫혔을 때 색상
                    backgroundColor: Colors.lightGreen, // 열렸을 때 색상
                    collapsedIconColor: Color.fromRGBO(51, 51, 51, 1), // 닫혔을 때 아이콘 색상
                    iconColor: Color.fromRGBO(51, 51, 51, 1), // 열렸을 때 아이콘 색상
                    title: Text('제목',  style: TextStyle(fontSize: 20, ), ),
                    shape:  RoundedRectangleBorder(  // 하위 목록이 확장될 때 타일의 테두리 모양입니다
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    children: [ Text('내용부분 입니다.'), ]
                  ),
              
                  // 기존 위젯에서 벗어나게 하는법
                  // clipBehavior: Clip.none,
                  // 참고 사이트 https://develop-designer.tistory.com/44
              
                  // Positioned 위치 고정 하는 법
                  // alignment: AlignmentDirectional.center,
                  // 참고 사이트
                  // https://stackoverflow.com/questions/50819354/flutter-position-stack-widget-in-center
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    // Stack 참고 사이트 https://ahang.tistory.com/24
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 300,
                          height: 100,
                          color: Colors.grey,
                        ),
                        Positioned(
                          width: 100,
                          height: 50,
                          child: Container(
                            color: Colors.lightGreen,
                          )
                        )
                      ],
                    ),
                  ),
              
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
              
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: const BoxDecoration(
                        // Border를 하단에만 줄 표시하기
                        // 참고 사이트
                        // https://stackoverflow.com/questions/47423297/how-can-i-add-a-border-to-a-widget-in-flutter
                        // https://googleflutter.com/flutter-container-border-left-right-top-bottom/
                        border: Border(
                          bottom: BorderSide(color: Colors.red, width: 5.3),
                        ),
                        color: Colors.teal,
                      ),
                    ),
                  ),
              
                  // 이미지파일을 아이콘으로 사용하고 싶을 때 ImageIcon위젯을 사용하면 된다.
                  // 참고 사이트 https://www.woolha.com/tutorials/flutter-using-imageicon-widget-examples
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageIcon(AssetImage('assets/images/hen.png'), size: 60,),
                        // 투명도 값 넣기 withOpacity(0.2)
                        // 참고 사이트 https://yj95.tistory.com/220
                        Icon(Icons.camera, color: Colors.black.withOpacity(0.2), size: 60,),
                      ],
                    ),
                  ),
              
                  // Text 글자를 일정길이를 넘어서면 ... 표시하는 법
                  // 참고 사이트
                  // https://velog.io/@gunwng123/Text-%EC%9C%84%EC%A0%AF%EC%97%90-%ED%91%9C%ED%98%84%ED%95%98%EA%B3%A0%EC%9E%90-%ED%95%98%EB%8A%94-String%EC%9D%98-%EA%B8%B8%EC%9D%B4%EA%B0%80-%EA%B8%B4-%EA%B2%BD%EC%9A%B0-%EC%B2%98%EB%A6%AC-%EB%B0%A9%EB%B2%95
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    width: 150,
                    child: const Text('제목테스트123456789101112131415',
                    style: TextStyle(color: Colors.black,),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    )
                  ),
              
                  // 참고 사이트 (gesturedetector 빈영역 클릭)
                  // https://cherry-forest.tistory.com/25
                  // https://velog.io/@dinb1242/Flutter-GestureDetector-%EB%B9%84%EC%96%B4-%EC%9E%88%EB%8A%94-%EC%98%81%EC%97%AD%EB%8F%84-%ED%84%B0%EC%B9%98-%EA%B0%80%EB%8A%A5%ED%95%98%EB%8F%84%EB%A1%9D-%ED%95%98%EA%B8%B0-HitTestBehavior
                  GestureDetector(
                    // 빈영역도 클릭되게 하는 방법
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      print('GestureDetector 클릭됨');
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('클릭'),
                          Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    // InkWell 클릭시 생성되는 효과 제거법
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      print('InkWell 클릭됨');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('클릭'),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
              
                  GestureDetector(
                    onTap: (){
                      debugPrint('빈 영역 클릭');
                      // Scaffold.of(context).hideCurrentSnackBar(); 중복 방지
                      // 참고 사이트 https://dopble2k.tistory.com/4
                      ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('빈 영역 클릭')),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.transparent,
                      ),
                      child: const Text('클릭 테스트'),
                    ),
                  ),
                  const SizedBox(height: 20,),
              
                  // 자식의 고유 높이에 맞게 자식 크기를 조정하는 위젯
                  IntrinsicHeight(
                    child: Container(
                      height: 200,
                      color: Colors.black,
                    ),
                  ),
                  // 자식의 최대 고유 너비에 맞게 자식 크기를 조정하는 위젯
                  IntrinsicWidth(
                    child: Container(
                      width: 200,
                      height: 100,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 10,),
              
                  // 모서리 둥글게 처라
                  // 참고 사이트
                  // https://yun-seyeong.tistory.com/19
                  // https://velog.io/@sharveka_11/ClipRRect
                  // https://muhly.tistory.com/15
                  // 18분 8초
                  // https://www.youtube.com/watch?v=DgKhGuI-q7g&list=PLfT5BC1zbOTtJGhpUH4EuxiqVr-yMYsMw&index=7
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  const SizedBox(height: 10,),
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child:  Image.asset('assets/images/icicles1280.jpg', width: 140, height: 70, fit: BoxFit.cover,),
                  ),
                  const SizedBox(height: 10,),
              
                  ClipOval(
                    child: SizedBox(
                      width: 170,
                      height: 70,
                      child:  Image.asset('assets/images/icicles1280.jpg', width: 140, height: 70, fit: BoxFit.fill,),
                    ),
                  ),
                  const SizedBox(height: 10,),
              
                  SizedBox(
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors.black,
                        ),
                        // 참고 사이트 https://velog.io/@sharveka_11/Spacer
                        const Spacer(),
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  // 참고 사이트
                  // https://initstory.tistory.com/126
                  // https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      constraints: const BoxConstraints(
                        maxWidth: 200,
                        maxHeight: 200
                      ),
                      color: Colors.greenAccent,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300,
                      height: 200,
                      color: Colors.greenAccent,
                    ),
                  ),

                  // 참고 사이트
                  // https://api.flutter.dev/flutter/widgets/UnconstrainedBox-class.html
                  // 디버그 모드에서 오버플로 발생하면 표시해주는 위젯
                  const UnconstrainedBox(
                    child: SizedBox(
                      width: 1000,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}