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
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              '${pitrType[index]} 점수 : ${score[index]}',
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
        ),
        if(index == 2) const SizedBox(height: 16.0),
      ],
    );
  }

  static Widget buildWidget({
    required List<int> pitrResult,
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
          itemCount: pitrResult.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    '$userName님의 \nPITR 진단 결과',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
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
