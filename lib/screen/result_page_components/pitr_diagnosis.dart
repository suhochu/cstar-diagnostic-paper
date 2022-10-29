import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

class PITRCheckResult {
  static List<String> pitrType = [
    '스트레스',
    '자원',
    '대처능력',
  ];

  static List<int> score = [0, 0, 0];

  static List<int> diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;

    score = [0, 0, 0];

    for (int i = 0; i < 16; i++) {
      if (answers[i] == 'A') {
        score[0]++;
      }
    }

    for (int i = 0; i < 16; i++) {
      if (answers[i + 16] == 'A') {
        score[1]++;
      }
    }

    for (int i = 0; i < 13; i++) {
      if (answers[i + 32] == 'A') {
        score[1]--;
      }
    }

    score[2] = score[1] - score[0];

    return score;
  }

  static Widget customListTile(int index) {
    return ListTile(
        title: Text(
          '${pitrType[index]} 점수 : ${score[index]}',
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        dense: true);
  }

  static Widget buildWidget({
    required List<int> pitrResult,
    required BuildContext context,
    required String userName,
  }) {
    // final maxValue = pitrResult.reduce(max);
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
          itemCount: pitrResult.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                  child: Text(
                    '$userName님의 PITR 진단 결과',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return customListTile(index - 1);
          },
        ),
      ),
    );
  }
}
