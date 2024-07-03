import 'package:flutter/material.dart';

class SimpleBarLayout extends StatelessWidget {
  final String title;
  final List<Widget>? topIcon;
  final List<Widget> children;
  final Widget? bottomNavigationBar;
  const SimpleBarLayout({
    required this.title,
    required this.topIcon,
    required this.children,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: topIcon,
        iconTheme: const IconThemeData(color: Colors.black45,),
        backgroundColor: Colors.white,
        title: Text(title, style: const TextStyle(color: Colors.black,),),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 720,
          child: Column(
            children: children,
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
