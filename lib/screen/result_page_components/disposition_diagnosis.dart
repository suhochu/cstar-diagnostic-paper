import 'dart:math';

import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/utils/string_extension.dart';
import 'package:flutter/material.dart';

class DispositionDiagnosisResult {
  static List<String> dispositionType1 = ['outgoing', 'neutral', 'introvert'];
  static List<String> dispositionType2 = ['sensibility', 'rationality'];

  static List<int> score1 = [0, 0, 0];
  static List<int> score2 = [0, 0];

  static DispositionResultModel diagnosis(List<String> results) {
    final List<Selections> answers = results.map((e) => e.getSelectionFromString()).toList();
    // List<Selections> answers = answerSheet.answers;
    score1 = [0, 0, 0];
    score2 = [0, 0];

    for (int i = 0; i < 14; i++) {
      if (answers[i] == Selections.A) {
        score1[0] += 1;
      } else if (answers[i] == Selections.B) {
        score1[1] += 1;
      } else if (answers[i] == Selections.C) {
        score1[2] += 1;
      } else {
        print('nothing have!!');
      }
    }
    for (int i = 0; i < 15; i++) {
      if (answers[i + 14] == Selections.A) {
        score2[0] += 1;
      } else if (answers[i + 14] == Selections.B) {
        score2[1] += 1;
      } else {
        print('nothing have!!');
      }
    }

    final int maxValue1 = score1.reduce(max);
    final int maxValue2 = score2.reduce(max);
    DispositionResultModel resultModel = DispositionResultModel(type1: [], type2: []);
    for (int i = 0; i < 3; i++) {
      if (score1[i] == maxValue1) {
        resultModel.type1.add(dispositionType1[i]);
      }
    }
    for (int i = 0; i < 2; i++) {
      if (score2[i] == maxValue2) {
        resultModel.type2.add(dispositionType2[i]);
      }
    }
    return resultModel;
  }

  static Widget customListTile1(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '${dispositionType1[index]} : ${score1[index]}',
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget customListTile2(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '${dispositionType2[index]} : ${score2[index]}',
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget buildWidget({
    required DispositionResultModel dispositionResult,
    required BuildContext context,
    required String userName,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
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
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    '$userName님의 \nDisposition 성향 진단 결과',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                children: [
                  const SizedBox(height: 8.0),
                  const Text(
                    '각 유형별 진단 점수',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8.0),
                  customListTile1(0),
                  customListTile1(1),
                  customListTile1(2),
                  const SizedBox(height: 8.0),
                  customListTile2(0),
                  customListTile2(1),
                  const SizedBox(height: 16.0),
                ],
              );
            }
            final type1resultLength = dispositionResult.type1.length;

            return ListTile(
              title: Text(
                type1resultLength == 1
                    ? '결과 : ${dispositionResult.type1[0]} / ${dispositionResult.type2[0]}'
                    : '결과 : ${dispositionResult.type1[0]}-${dispositionResult.type1[1]} / ${dispositionResult.type2[0]}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
