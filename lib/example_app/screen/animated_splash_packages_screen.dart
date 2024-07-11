import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../select_test.dart';
import 'widget/default_scaffold.dart';

// 참고 사이트
// animated_splash_screen full screen
// https://stackoverflow.com/questions/69255828/size-for-image-asset-not-changing-in-animated-splash-screen

class AnimatedSplashPackageScreen extends StatelessWidget {
  const AnimatedSplashPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      body: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/images/hamburger.png'),
        nextScreen: const SelectTest(),
        splashIconSize: double.infinity,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
