import 'dart:math';

import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/utils/string_extension.dart';
import 'package:flutter/material.dart';

class StressDiagnosisResult {
  static List<String> stressType = ['행동-공격형', '공유-비난형', '자책-자해형', '고립-은둔형'];

  static List<int> score = [0, 0, 0, 0];

  static List<StressDiagnosisResultModel> diagnosis(List<String> results) {
    final List<Selections> answers = results.map((e) => e.getSelectionFromString()).toList();
    final List<StressDiagnosisResultModel> resultType = [];
    score = [0, 0, 0, 0];

    for (var i in answers) {
      if (i == Selections.A) {
        score[0] += 1;
      } else if (i == Selections.B) {
        score[1] += 1;
      } else if (i == Selections.C) {
        score[2] += 1;
      } else if (i == Selections.D) {
        score[3] += 1;
      } else {
        print('nothing have!!');
      }
    }

    final int maxValue = score.reduce(max);
    for (int i = 0; i < 4; i++) {
      if (score[i] == maxValue) {
        resultType.add(StressDiagnosisResultModel(type: stressType[i]));
      }
    }

    return resultType;
  }

  static Widget customListTile(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '${stressType[index]} : ${score[index]}',
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget buildWidget({
    required List<StressDiagnosisResultModel> stressDiagnosisResult,
    required BuildContext context,
    required String userName,
    required List<int> score,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 5,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: stressDiagnosisResult.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExpansionTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    '$userName님의 \n스트레스 유형 진단 결과',
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
                  customListTile(0),
                  customListTile(1),
                  customListTile(2),
                  customListTile(3),
                  const SizedBox(height: 16.0),
                ],
              );
            }

            return ListTile(
              title: Text(
                '결과 : ${stressDiagnosisResult[index - 1].type}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              contentPadding: const EdgeInsets.all(8.0),
            );
          },
        ),
      ),
    );
  }
}
