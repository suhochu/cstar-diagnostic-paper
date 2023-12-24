import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:flutter/material.dart';

import '../constants/data_contants.dart';

class ColorDisposition extends QAndAData<List<Selections>> {
  ColorDisposition(
      {super.test = Test.colorDisposition,
      super.selectionType = SelectionType.checkBox,
      super.subTitle = const Column(
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
      )}) {
    initiatedResultList();
  }

  @override
  bool validator(List<Selections> result) {
    bool isValid = false;
    for (int i = 0; i < 20; i++) {
      final List<Selections> toBeValidated = [
        result[i],
        result[i + 20],
        result[i + 40],
        result[i + 60],
      ];
      int count = 0;
      for (var i in toBeValidated) {
        if (i == Selections.ndf) count++;
      }
      if (count > 2) break;
      if (i == 19) isValid = true;
    }
    return isValid;
  }
}
