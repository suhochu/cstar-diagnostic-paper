import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/guestion_card_color_disposition.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/pitr_card.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/question_card.dart';
import 'package:cstarimage_testpage/screen/selections/diaganosis_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../provider/answer_sheet_provider.dart';
import '../result_page.dart';

class NewQuestionSheet extends ConsumerWidget {
  static String get routeName => 'NewQuestionsSheet';

  const NewQuestionSheet({
    super.key,
    required this.test,
  });

  // final QAndAData? qAndAData;
  final Test? test;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (test == null) {
      context.goNamed(DiagnosisSelectionPage.routeName);
      return Container();
    }
    final qAndAData = test?.selectQAndData();
    final int questionLength;
    switch (test) {
      case Test.colorDisposition:
        questionLength = 20;
      case _:
        questionLength = qAndAData!.questions.length;
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: questionLength + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 8, right: 16),
                  child: const Text(
                    "본 진단지 저작권은 '씨스타이미지'에 있습니다.",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    qAndAData!.test.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                if (qAndAData!.subTitle != null) qAndAData!.subTitle!,
                const SizedBox(height: 8),
                if (qAndAData!.explanations != null) qAndAData!.explanations!,
              ],
            );
          }

          if (index == questionLength + 1) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  final (SelectionType, bool, bool) result = (
                    qAndAData!.selectionType,
                    ref.read(answerSheetProvider.notifier).containNdf(qAndAData!.test),
                    qAndAData!.validator(ref.read(answerSheetProvider.notifier).returnSelectionsList(qAndAData!.test)),
                  );
                  switch (result) {
                    case (SelectionType.checkBox, true, false):
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            '2가지 항목이상 점수를 주신 않은 문항이 있습니다.\n모든 문항에 대해서 2가지 항목 이상에 대해서 1점 이상의 점수를 주세요',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                      break;
                    case (SelectionType.radio, true, _):
                    case (SelectionType.radio, false, false):
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            '선택 안된 항목이 있습니다. 전부 작성 부탁드립니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );

                      break;
                    case (_, _, _):
                      context.goNamed(ResultPage.routeName);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '제출하기',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            );
          }

          switch (qAndAData!.test) {
            case Test.pitr:
              return Container(
                alignment: Alignment.center,
                child: PitrCard(
                  questions: qAndAData!.questions[index - 1],
                  index: index - 1,
                  test: qAndAData!.test,
                ),
              );
            case Test.colorDisposition:
              return ColorDispositionQuestionCard(
                questions: [
                  qAndAData!.questions[index - 1],
                  qAndAData!.questions[(index + 20) - 1],
                  qAndAData!.questions[(index + 40) - 1],
                  qAndAData!.questions[(index + 60) - 1],
                ],
                index: index,
                questionQty: qAndAData!.questions.length,
              );
            case Test.dispositionTest:
            case Test.personalColorSelfTest:
            case Test.stressResponseQuestions:
              return QuestionCard(
                question: qAndAData!.questions[index - 1],
                index: index,
                answers: (qAndAData!.answers[index - 1]) as List<String>,
                test: qAndAData!.test,
              );
            case _:
              return QuestionCard(
                question: qAndAData!.questions[index - 1],
                index: index,
                answers: (qAndAData!.answers) as List<String>,
                test: qAndAData!.test,
              );
          }
        },
      ),
    );
  }
}
