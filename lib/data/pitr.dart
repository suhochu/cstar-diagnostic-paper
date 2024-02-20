import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:flutter/material.dart';

import '../model/lecture_code.dart';

class Pitr extends QAndAData {
  Pitr(
      {super.test = Test.pitr,
      super.subTitle = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '각 문항이 해당 사항이 있으면 체크 부탁드립니다.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      )}) {
    initiatedResultList();
  }
}
