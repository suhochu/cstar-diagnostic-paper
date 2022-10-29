import 'dart:math';

import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

class ColorDispositionCheckResult {
  static List<String> colorDiscomposeType = [
    'T',
    'B',
    'R',
    'M',
    'V',
    'G',
    'BG',
    'O',
    'I',
    'RO',
    'Y',
    'YG',
    'P',
    'Br',
    'Wh',
    'BI'
  ];
  static List<List<int>> indexWithTypes = [
    [1, 5, 9, 13, 17],
    [2, 6, 10, 14, 18],
    [3, 7, 11, 15, 19],
    [4, 8, 12, 16, 20],
    [21, 25, 29, 33, 37],
    [22, 26, 30, 34, 38],
    [23, 27, 31, 35, 39],
    [24, 28, 32, 36, 40],
    [41, 45, 49, 53, 57],
    [42, 46, 50, 54, 58],
    [43, 47, 51, 55, 59],
    [44, 48, 52, 56, 60],
    [61, 65, 69, 73, 77],
    [62, 66, 70, 74, 78],
    [63, 67, 71, 75, 79],
    [64, 68, 72, 76, 80],
  ];

  static List<int> score = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  static List<int> diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;
    print('answerSheet ${answerSheet.answers}');

    score = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    for (int j = 0; j < indexWithTypes.length; j++) {
      for (var i in indexWithTypes[j]) {
        if (answers[i - 1] == 'A') {
          score[j]++;
        }
      }
    }
    print('score is ${score.toString()}');
    return score;
  }

  static Widget customListTile(int index, bool maxValue) {
    return ListTile(
        title: Text(
          '${colorDiscomposeType[index]} : ${score[index]}',
          style: TextStyle(
            fontSize: maxValue ? 20 : 16,
            color: maxValue ? Colors.red : null,
            fontWeight: maxValue ? FontWeight.w500 : null,
          ),
          textAlign: TextAlign.center,
        ),
        dense: true);
  }

  static Widget buildWidget({
    required List<int> colorDispositionResult,
    required BuildContext context,
    required String userName,
  }) {
    final maxValue = colorDispositionResult.reduce(max);
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 5,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: colorDispositionResult.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    '$userName님의 Color Disposition 유형 진단 결과',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            int currentScore = colorDispositionResult[index - 1];
            bool isMaxValue = maxValue == currentScore;
            return customListTile(index - 1, isMaxValue);
          },
        ),
      ),
    );
  }
}
