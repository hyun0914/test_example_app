import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../select_test.dart';

// 참고 사이트
// https://velog.io/@meibinlee/Flutter-Onboarding-Screen

class IntroductionPackagesScreen extends StatelessWidget {
  const IntroductionPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'hen',
          body: 'hen',
          image: Image.asset('assets/images/hen.png', height: MediaQuery.of(context).size.height,),
          decoration: const PageDecoration(
            fullScreen: true,
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green
            ),
            bodyTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            imagePadding: EdgeInsets.only(bottom: 10),
            //pageColor: Colors.blue
          ),
        ),
        PageViewModel(
          title: 'pizza',
          body: 'pizza',
          image: Image.asset('assets/images/pizza.png', height: MediaQuery.of(context).size.height,),
          decoration: const PageDecoration(
            fullScreen: true,
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green
            ),
            bodyTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            imagePadding: EdgeInsets.only(bottom: 10),
            //pageColor: Colors.blue
          ),
        ),
        PageViewModel(
          title: 'chicken',
          body: 'chicken',
          image: Image.asset('assets/images/chicken.jpg', height: MediaQuery.of(context).size.height,),
          decoration: const PageDecoration(
            fullScreen: true,
            titleTextStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green
            ),
            bodyTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            imagePadding: EdgeInsets.only(bottom: 10),
            //pageColor: Colors.blue
          ),
        ),
      ],
      done: const Text('done'),
      onDone: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SelectTest()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: const Text('skip'),
      dotsDecorator: DotsDecorator(
        color: Colors.black,
        size: const Size(12,12),
        activeSize: const Size(22,12),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22)
        ),
        activeColor: Colors.grey
      ),
      curve: Curves.ease,
    );
  }
}
