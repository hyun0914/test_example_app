import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'banner_details_page.dart';

class BannerPage extends StatefulWidget {
  final List imgList;
  const BannerPage({
    required this.imgList,
    super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  // 참고 사이트
  // https://box-world.tistory.com/74
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;
      if(nextPage > widget.imgList.length-1){
        nextPage = 0;
      }

      controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    if(timer != null){
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: 720,
              child: PageView.builder(
                itemCount: widget.imgList.length,
                controller: controller,
                itemBuilder: (_, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BannerDetailsPage(imgName: widget.imgList[index]))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        widget.imgList[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12,),
          SmoothPageIndicator(
            onDotClicked: (index){ controller.jumpToPage(index); },
            controller: controller,  // PageController
            count:  widget.imgList.length,
            textDirection: TextDirection.ltr,
            effect: const ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 8,
              dotColor: Colors.grey,
              activeDotColor: Colors.green
            ),
          ),
        ],
      ),
    );
  }
}

