import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  DefaultLayout({Key? key, required this.child, this.appbar}) : super(key: key);
  final Widget child;
  AppBar? appbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
