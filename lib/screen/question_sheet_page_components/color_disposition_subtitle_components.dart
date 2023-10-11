import 'package:flutter/material.dart';

class ColorDispositionSubtitleComponents {
  static Widget subtitle = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '각 문항당 최소 2가지 이상의 항목을 선택 바랍니다.',
          style: TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}
