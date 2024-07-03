import 'package:flutter/material.dart';

import 'widget/default_scaffold.dart';

List<Object> tagList = [
  'heroGreen',
  'heroYellow'
];

List<Color> boxColor = [
  Colors.green[700]!.withOpacity(0.5),
  Colors.yellow[700]!.withOpacity(0.5),
];

List<String> title = [
  'Green Box',
  'Yellow Box',
];

class HeroScreen extends StatelessWidget {
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      appBar: AppBar(title: const Text('Hero Sample')),
      body: Column(
        children: [
          for(int i=0; i<2; i++)
          Column(
            children: [
              ListTile(
                leading: Hero(
                  tag: tagList[i],
                  createRectTween: i == 1?
                    (Rect? begin, Rect? end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  } : null,
                  child: BoxWidget(
                    size: const Size(50.0, 50.0),
                    color: boxColor[i],
                  ),
                ),
                title: Text(title[i]),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
          ElevatedButton(
            onPressed: () => gotoDetailsPage(context: context, tagList: tagList, boxColor: boxColor,),
            child: const Text('hero Test'),
          ),
        ],
      ),
    );
  }

  void gotoDetailsPage({
    required BuildContext context,
    required List<Object> tagList,
    required List<Color> boxColor,
}) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Hero Test Page'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              for(int i=0; i<2; i++)
              Hero(
                tag: tagList[i],
                createRectTween: i == 0?
                (Rect? begin, Rect? end) {
                  return MaterialRectCenterArcTween(begin: begin, end: end);
                } : null,
                child: BoxWidget(
                  size: const Size(400.0, 400.0),
                  color: boxColor[i],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.size,
    required this.color,
  });

  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: color,
    );
  }
}