import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

import 'widget/default_scaffold.dart';

class OnboardPackagesScreen extends StatelessWidget {
  const OnboardPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return DefaultScaffold(
      body: OnBoard(
        pageController: pageController,
        onSkip: () {},
        onDone: () {},
        onBoardData: [
          for(int i=0; i<2; i++)
          OnBoardModel(
            title: 'title area $i',
            description: 'description area $i',
            imgUrl: 'assets/images/hen.png'
          ),
        ],
        titleStyles: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.15,
        ),
        descriptionStyles: const TextStyle(
          fontSize: 16,
          color: Colors.lightGreen,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Colors.lime,
          activeColor: Colors.limeAccent,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12)
        ),
        skipButton: TextButton(
          onPressed: () {},
          child: const Text(
            'SKIP',
            style: TextStyle(color: Colors.teal),
          ),
        ),
        nextButton: GestureDetector(
          onTap: () {
            pageController.animateToPage(
              pageController.initialPage+1,
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeInCirc,
            );
          },
          child: Container(
            width: 240,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: const LinearGradient(
                colors: [
                  Colors.orangeAccent,
                  Colors.yellow
                ],
              ),
            ),
            child: Text(
              'NEXT',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
