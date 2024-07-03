import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

// 참고 사이트
// https://iosroid.tistory.com/82

class AnimatedWidgetScreen extends StatefulWidget {
  const AnimatedWidgetScreen({super.key});

  @override
  State<AnimatedWidgetScreen> createState() => _AnimatedWidgetScreenState();
}

class _AnimatedWidgetScreenState extends State<AnimatedWidgetScreen> {
  bool selected = false;
  bool selected2 = false;
  int count = 0;
  bool selected3 = false;
  double opacityLevel = 1.0;
  double padValue = 0.0;
  bool selected4 = true;
  bool selected5 = false;
  bool selected6 = true;
  bool selected7 = true;
  double size = 50.0;
  bool large = false;

  TextStyle textStyle() {
    return selected3
    ? const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w900,
      fontSize: 14
    )
    : const TextStyle(
      color: Colors.cyan,
      fontWeight: FontWeight.w400,
      fontSize: 40
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 참고 사이트
              // https://velog.io/@tygerhwang/FLUTTER-AnimatedContainer
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                child: Center(
                  child: AnimatedContainer(
                    width: selected ? 200.0 : 100.0,
                    height: selected ? 100.0 : 200.0,
                    color: selected ? Colors.greenAccent : Colors.blue,
                    alignment:
                    selected ? Alignment.center : AlignmentDirectional.topCenter,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: const FlutterLogo(size: 75),
                  ),
                ),
              ),
          
              const SizedBox(height: 10,),

              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        '$count',
                        key: ValueKey<int>(count),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('+1 증가'),
                      onPressed: () {
                        setState(() {
                          count += 1;
                        });
                      },
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 10,),

              GestureDetector(
                onTap: () {
                  setState(() {
                    selected2 = !selected2;
                  });
                },
                child: Container(
                  width: 240,
                  height: 240,
                  color: Colors.lightGreen,
                  child: AnimatedAlign(
                    alignment: selected2? Alignment.topCenter : Alignment.bottomCenter,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: const FlutterLogo(size: 40,),
                  ),
                ),
              ),
          
              const SizedBox(height: 10,),

              GestureDetector(
                onTap: () {
                  setState(() {
                    selected3 = !selected3;
                  });
                },
                child: AnimatedDefaultTextStyle(
                  style: textStyle(),
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  child: const Text("디폴트 글자 스타일"),
                ),
              ),
          
              const SizedBox(height: 10,),

              AnimatedOpacity(
                opacity: opacityLevel,
                duration: const Duration(seconds: 4),
                child: const FlutterLogo(),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
                },
                child: const Text('투명'),
              ),
          
              const SizedBox(height: 10,),

              AnimatedPadding(
                padding: EdgeInsets.all(padValue),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  color: Colors.green,
                ),
              ),
              Text('Padding: $padValue'),
              ElevatedButton(
                child: const Text('Change padding'),
                onPressed: () {
                  setState(() {
                    padValue = padValue == 0.0? 80.0 : 0.0;
                  });
                }
              ),

              const SizedBox(height: 10,),

              AnimatedPhysicalModel(
                shape: BoxShape.rectangle,
                borderRadius: selected4 ? BorderRadius.circular(16.0) : BorderRadius.zero,
                elevation: selected4 ? 10.0 : 20.0,
                color: selected4? Colors.black : Colors.green,
                shadowColor: selected4? Colors.lime : Colors.indigoAccent,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                child: const SizedBox(
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              Container(height: 10.0,),
              ElevatedButton(
                onPressed: () => setState(() {
                  selected4 = !selected4;
                }),
                child: const Text("클릭"),
              ),

              const SizedBox(height: 10,),

              SizedBox(
                width: 160,
                height: 360,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      width: selected5 ? 160.0 : 50.0,
                      height: selected5 ? 50.0 : 200.0,
                      top: selected5 ? 50.0 : 150.0,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected5 = !selected5;
                          });
                        },
                        child: const ColoredBox(
                          color: Colors.indigo,
                          child: Center(child: Text('클릭')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 160,
                height: 360,
                child: Stack(
                  children: [
                    AnimatedPositionedDirectional(
                      width: selected5 ? 160.0 : 50.0,
                      height: selected5 ? 50.0 : 200.0,
                      top: selected5 ? 50.0 : 150.0,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected5 = !selected5;
                          });
                        },
                        child: const ColoredBox(
                          color: Colors.limeAccent,
                          child: Center(child: Text('클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭클릭')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              AnimatedTheme(
                data: selected6 ? ThemeData.light() : ThemeData.dark(),
                child: Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  selected6 = !selected6;
                }),
                child: const Text("클릭"),
              ),

              const SizedBox(height: 10,),

              const TweenAnimationBuilderEx(),

              const SizedBox(height: 10,),

              AnimatedCrossFade(
                firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 120.0),
                secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 120.0),
                crossFadeState: selected7 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(seconds: 1),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  selected7 = !selected7;
                }),
                child: const Text("클릭"),
              ),

              const SizedBox(height: 10,),

              GestureDetector(
                onTap: () {
                  setState(() {
                    size = large ? 250.0 : 100.0;
                    large = !large;
                  });
                },
                child: ColoredBox(
                  color: Colors.lightGreenAccent,
                  child: AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(seconds: 1),
                    child: FlutterLogo(size: size),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TweenAnimationBuilderEx extends StatefulWidget {
  const TweenAnimationBuilderEx({super.key});

  @override
  State<TweenAnimationBuilderEx> createState() => _TweenAnimationBuilderExState();
}

class _TweenAnimationBuilderExState extends State<TweenAnimationBuilderEx> {
  double targetValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double size, Widget? child) {
        return IconButton(
          iconSize: size,
          color: Colors.green,
          icon: child!,
          onPressed: () {
            setState(() {
              targetValue = targetValue == 20.0 ? 60.0 : 20.0;
            });
          },
        );
      },
      child: const Icon(Icons.cake),
    );
  }
}