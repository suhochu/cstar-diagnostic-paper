import 'package:flutter/material.dart';

import 'lecture_code.dart';

enum SelectionType { radio, checkBox }

class QAndAData<T, U> {
  final bool hasIndividualAnswers = false;
  final Test test = Test.colorDisposition;
  final List<String> questions = [];
  final List<T> answers = [];
  final Widget? subTitle;
  final Widget? explanations;
  final SelectionType selectionType = SelectionType.radio;
  final List<String> result = [];

  bool validator(U result) => true;

  QAndAData({
    this.subTitle,
    this.explanations,
  }) {
    result.addAll(List.generate(questions.length, (index) => ''));
  }
}
