import 'package:flutter/material.dart';

import 'lecture_code.dart';

enum SelectionType { radio, checkBox }

class QAndAData<U> {
  final bool hasIndividualAnswers;
  final Test test;
  Widget? subTitle;
  Widget? explanations;
  final SelectionType selectionType;
  final List<String> result = [];
  // int length = 0;
  // final bool hasIndividualAnswers = false;
  // final Test test = Test.colorDisposition;
  // final List<String> questions = [];
  // final List<T> answers = [];
  // final Widget? subTitle;
  // final Widget? explanations;
  // final SelectionType selectionType = SelectionType.radio;



  bool validator(U result) => true;

  void initiatedResultList(){
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
