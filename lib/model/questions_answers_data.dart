import 'package:flutter/material.dart';

import 'lecture_code.dart';

enum SelectionType { radio, checkBox }

class QAndAData {
  final bool hasIndividualAnswers;
  final Test test;
  Widget? subTitle;
  Widget? explanations;
  final SelectionType selectionType;
  final List<String> result = [];

  bool validator(List<String> result) => true;

  void initiatedResultList() {
    result.clear();
    result.addAll(List.generate(test.lengthOfQuestions(), (index) => ''));
  }

  QAndAData({
    required this.test,
    this.hasIndividualAnswers = false,
    this.selectionType = SelectionType.radio,
    this.subTitle,
    this.explanations,
  });
}
