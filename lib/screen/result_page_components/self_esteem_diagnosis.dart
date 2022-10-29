import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

class SelfEsteemResult {
  static int score = 0;

  static int diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;
    score = 0;

    for (var i in answers) {
      if (i == 'A') {
        score += 1;
      } else if (i == 'B') {
        score += 2;
      } else if (i == 'C') {
        score += 3;
      } else if (i == 'D') {
        score += 4;
      } else {
        print('nothing have!!');
      }
    }

    return score;
  }

  static Widget buildWidget({
    required BuildContext context,
    required String userName,
    required int score,
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
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                child: Text(
                  '$userName님의 자존감 진단 결과',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListTile(
              title: Text(
                '결과 : ${score.toString()}점',
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
