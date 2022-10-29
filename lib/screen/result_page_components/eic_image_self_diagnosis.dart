import 'dart:math';

import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

class EicTypeResult {
  static List<String> eicType = ['E', 'I', 'C'];
  static List<List<int>> indexWithTypes = [
    [1, 4, 7, 10, 14, 18, 21, 24, 27, 29, 33, 36, 39, 42, 45, 47, 50],
    [3, 5, 9, 11, 13, 16, 20, 23, 26, 28, 30, 32, 35, 37, 41, 43, 48],
    [2, 6, 8, 12, 15, 17, 19, 22, 25, 31, 34, 38, 40, 44, 46, 49, 51],
  ];

  //E, I, C
  static List<int> score = [0, 0, 0];

  static List<EicDiagnosisResultModel> diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;

    score = [0, 0, 0];
    for (int j = 0; j < 3; j++) {
      for (var i in indexWithTypes[j]) {
        if (answers[i - 1] == 'A') {
          score[j] += 1;
        }
      }
    }

    List<int> decidedIndex = decideWhichTypeIsMaxScore(score);
    List<EicDiagnosisResultModel> decidedTypes = [];
    for (var i in decidedIndex) {
      EicDiagnosisResultModel eicDiagnosisResultModel = EicDiagnosisResultModel(type: eicType[i]);
      decidedTypes.add(eicDiagnosisResultModel);
    }
    return decidedTypes;
  }

  static List<int> decideWhichTypeIsMaxScore(List<int> score) {
    final int maxScore = score.reduce(max);
    List<int> indexAtMaxValue = [];
    for (int i = 0; i < score.length; i++) {
      if (score[i] == maxScore) {
        indexAtMaxValue.add(i);
      }
    }
    return indexAtMaxValue;
  }

  static String buildEicTypeName(List<EicDiagnosisResultModel> result) {
    if (result.length == 3) {
      return 'EIC';
    }
    if (result.length == 1) {
      return result[0].type;
    }

    return '${result[0].type}${result[1].type}';
  }

  static Widget customListTile(int index) {
    return ListTile(
        title: Text(
          '${eicType[index]} : ${score[index]}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        dense: true);
  }

  static Widget buildWidget({
    required List<EicDiagnosisResultModel> eicDiagnosisResult,
    required BuildContext context,
    required String userName,
    required List<int> score,
  }) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 5,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExpansionTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    '$userName님의 EIC 유형 진단 결과',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                children: [
                  const Text(
                    '각 유형별 진단 점수',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  customListTile(0),
                  const SizedBox(
                    height: 8.0,
                  ),
                  customListTile(1),
                  const SizedBox(
                    height: 8.0,
                  ),
                  customListTile(2),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              );
            }

            return ListTile(
              title: Text(
                score.reduce((value, element) => value + element) != 0 ? '결과 : ${buildEicTypeName(
                    eicDiagnosisResult)} 타입' : '아무것도 선택하지 않으셨습니다. 테스트를 다시해 주세요',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              contentPadding: const EdgeInsets.all(16.0),
            );
          },
        ),
      ),
    );
  }
}
