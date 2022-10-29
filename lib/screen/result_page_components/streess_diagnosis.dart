import 'dart:math';

import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

class StressDiagnosisResult {
  static List<String> stressType = ['행동-공격형', '공유-비난형', '자책-자해형', '고립-은둔형'];

  static List<int> score = [0, 0, 0, 0];

  static List<StressDiagnosisResultModel> diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;
    List<StressDiagnosisResultModel> resultType = [];
    score = [0, 0, 0, 0];

    for (var i in answers) {
      if (i == 'A') {
        score[0] += 1;
      } else if (i == 'B') {
        score[1] += 1;
      } else if (i == 'C') {
        score[2] += 1;
      } else if (i == 'D') {
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

  static Widget customListTile(int index){
    return ListTile(
        title: Text(
          '${stressType[index]} : ${score[index]}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        dense: true);
  }

  static Widget buildWidget({
    required List<StressDiagnosisResultModel> stressDiagnosisResult,
    required BuildContext context,
    required String userName,
    required List<int> score,
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
          itemCount: stressDiagnosisResult.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExpansionTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    '$userName님의 스트레스 유형 진단 결과',
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
                  const SizedBox(height: 16.0,),
                  customListTile(0),
                  const SizedBox(height: 8.0,),
                  customListTile(1),
                  const SizedBox(height: 8.0,),
                  customListTile(2),
                  const SizedBox(height: 8.0,),
                  customListTile(3),
                ],
              );
            }

            return ListTile(
              title: Text(
                '결과 : ${stressDiagnosisResult[index - 1].type}',
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
