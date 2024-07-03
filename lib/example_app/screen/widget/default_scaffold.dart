import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  const DefaultScaffold({
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(),
      floatingActionButton: floatingActionButton,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
