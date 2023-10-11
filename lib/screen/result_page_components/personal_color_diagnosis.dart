import 'package:flutter/material.dart';

import '../../model/answer_sheet_model.dart';

class PersonalColorDiagnosisResult {
  static List<int> score = [0, 0, 0];
  static List<String> personalColorType = ['웜톤', '중성', '쿨톤'];

  static List<int> diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;
    List<int> localScore = [0, 0, 0];
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == 'A') {
        localScore[0] += 1;
      } else if (answers[i] == 'B') {
        localScore[1] += 1;
      } else if (answers[i] == 'C') {
        localScore[2] += 1;
      } else {
        print('nothing have!!');
      }
    }
    return localScore;
  }

  static Widget customListTile(int index, int score) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '${personalColorType[index]} : $score',
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget buildWidget({
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
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExpansionTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    '$userName님의 \v퍼스털 컬러 셀프 진단 결과',
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
                  customListTile(0, score[0]),
                  customListTile(1, score[1]),
                  customListTile(2, score[2]),
                  const SizedBox(height: 16.0),
                ],
              );
            }
            final int maxValue = score.reduce((current, next) => current > next ? current : next);
            final List<String> myTypeString = [];
            for (int i = 0; i <= 2; i++) {
              if (score[i] == maxValue) {
                myTypeString.add(personalColorType[i]);
              }
            }
            final String resultString = myTypeString.join(' / ');
            return ListTile(
              title: Text(
                resultString,
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
