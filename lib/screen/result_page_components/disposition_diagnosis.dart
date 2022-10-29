import 'dart:math';

import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

enum TYPE { type1, type2 }

class DispositionDiagnosisResult {
  static List<String> dispositionType1 = ['OutGoing', 'neutral', 'introvert'];
  static List<String> dispositionType2 = ['sensibility', 'rationality'];

  static List<int> score1 = [0, 0, 0];
  static List<int> score2 = [0, 0];

  static List<DispositionResultModel> diagnosis(AnswerSheetModel answerSheet, TYPE type) {
    List<String?> answers = answerSheet.answers;
    List<DispositionResultModel> resultType = [];
    score1 = [0, 0, 0];
    score2 = [0, 0];

    for (int i = 0; i < 14; i++) {
      if (answers[i] == 'A') {
        score1[0] += 1;
      } else if (answers[i] == 'B') {
        score1[1] += 1;
      } else if (answers[i] == 'C') {
        score1[2] += 1;
      } else {
        print('nothing have!!');
      }
    }
    for (int i = 0; i < 15; i++) {
      if (answers[i + 14] == 'A') {
        score2[0] += 1;
      } else if (answers[i + 14] == 'B') {
        score2[1] += 1;
      } else {
        print('nothing have!!');
      }
    }

    final int maxValue1 = score1.reduce(max);
    final int maxValue2 = score2.reduce(max);
    DispositionResultModel resultModel = DispositionResultModel(type1: '', type2: '');
    for (int i = 0; i < 3; i++) {
      if (score1[i] == maxValue1) {
        resultModel = resultModel.copyWith(type1: dispositionType1[i]);
      }
    }
    for (int i = 0; i < 2; i++) {
      if (score2[i] == maxValue2) {
        resultModel = resultModel.copyWith(type2: dispositionType2[i]);
      }
    }

    resultType.add(resultModel);
    return resultType;
  }

  static Widget customListTile1(int index) {
    return ListTile(
        title: Text(
          '${dispositionType1[index]} : ${score1[index]}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        dense: true);
  }

  static Widget customListTile2(int index) {
    return ListTile(
        title: Text(
          '${dispositionType2[index]} : ${score2[index]}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        dense: true);
  }

  static Widget buildWidget({
    required List<DispositionResultModel> dispositionResult,
    required BuildContext context,
    required String userName,
  }) {
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
          itemCount: dispositionResult.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExpansionTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    '$userName님의 성향 진단 결과',
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
                  customListTile1(0),
                  const SizedBox(
                    height: 8.0,
                  ),
                  customListTile1(1),
                  const SizedBox(
                    height: 8.0,
                  ),
                  customListTile1(2),
                  const SizedBox(
                    height: 8.0,
                  ),
                  customListTile2(0),
                  const SizedBox(
                    height: 8.0,
                  ),
                  customListTile2(1),
                ],
              );
            }

            return ListTile(
              title: Text(
                '결과 : ${dispositionResult[index - 1].type1} / ${dispositionResult[index - 1].type2}',
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
