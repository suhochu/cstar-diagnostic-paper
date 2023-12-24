import 'package:cstarimage_testpage/constants/answers.dart';
import 'package:cstarimage_testpage/constants/questions.dart';
import 'package:cstarimage_testpage/data/disposition_test.dart';
import 'package:cstarimage_testpage/data/eic_image.dart';
import 'package:cstarimage_testpage/data/leadership_questions.dart';
import 'package:cstarimage_testpage/data/personal_color_self.dart';
import 'package:cstarimage_testpage/data/pitr.dart';
import 'package:cstarimage_testpage/data/self_esteem_questions.dart';
import 'package:cstarimage_testpage/data/stress_response_questions.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/guestion_card_color_disposition.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/pitr_card.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/question_card.dart';
import 'package:cstarimage_testpage/screen/selections/diaganosis_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

import '../../data/color_disposition.dart';
import '../../provider/answer_sheet_provider.dart';
import '../result_page.dart';

class NewQuestionSheet extends ConsumerWidget {

  const NewQuestionSheet({
    super.key,
    required this.test,
  });

  final Test? test;

  QAndAData selectQAndData(Test test) {
    switch (test) {
      case Test.colorDisposition:
        return ColorDisposition();
      case Test.dispositionTest:
        return DispositionTest();
      case Test.eicImage:
        return EicImage();
      case Test.leadershipQuestions:
        return LeadershipQuestions();
      case Test.personalColorSelfTest:
        return PersonalColorSelfTest();
      case Test.pitr:
        return Pitr();
      case Test.selfEsteemQuestions:
        return SelfEsteemQuestions();
      case Test.stressResponseQuestions:
        return StressResponseQuestions();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (test == null) {
      // Navigator.of(context).pushNamed("/diagnosisSelectionPage");
      context.goNamed('diagnosisSelectionPage');
      return Container();
    }
    final qAndAData = selectQAndData(test!);
    final int questionLength;
    switch (test) {
      case Test.colorDisposition:
        questionLength = 20;
      case _:
        questionLength = test!.lengthOfQuestions();
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
                if (qAndAData.subTitle != null) qAndAData.subTitle!,
                const SizedBox(height: 8),
                if (qAndAData.explanations != null) qAndAData.explanations!,
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
                    ref.read(answerSheetProvider.notifier).containNdf(qAndAData.test),
                    qAndAData.validator(ref.read(answerSheetProvider.notifier).returnSelectionsList(qAndAData.test)),
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
                      // Navigator.of(context).pushNamed("/ResultPage");
                      context.goNamed('ResultPage');
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

          final answer = Answers();
          final questions = Questions();
          switch (qAndAData.test) {
            case Test.pitr:
              return Container(
                alignment: Alignment.center,
                child: PitrCard(
                  questions: questions.qPitr[index - 1],
                  index: index - 1,
                  test: Test.pitr,
                ),
              );
            case Test.colorDisposition:
              return ColorDispositionQuestionCard(
                questions: [
                  questions.qColorDisposition[index - 1],
                  questions.qColorDisposition[(index + 20) - 1],
                  questions.qColorDisposition[(index + 40) - 1],
                  questions.qColorDisposition[(index + 60) - 1],
                ],
                index: index,
                questionQty: questions.qColorDisposition.length,
              );
            case Test.dispositionTest:
              return QuestionCard(
                question: questions.qDispositionTest[index - 1],
                index: index,
                answers: answer.aDispositionTest[index - 1],
                test: Test.dispositionTest,
              );

            case Test.personalColorSelfTest:
              return QuestionCard(
                question: questions.qPersonalColorSelfTest[index - 1],
                index: index,
                answers: answer.aPersonalColorSelfTest[index - 1],
                test: Test.personalColorSelfTest,
              );

            case Test.stressResponseQuestions:
              return QuestionCard(
                question: questions.qStressResponseQuestions[index - 1],
                index: index,
                answers: answer.aStressResponseQuestions[index - 1],
                test: Test.stressResponseQuestions,
              );

            case Test.eicImage:
              return QuestionCard(
                question: questions.qEicImage[index - 1],
                index: index,
                answers: answer.aEicImage,
                test: Test.eicImage,
              );
            case Test.leadershipQuestions:
              return QuestionCard(
                question: questions.qLeaderShipQuestions[index - 1],
                index: index,
                answers: answer.aLeadershipQuestions,
                test: Test.leadershipQuestions,
              );
            case Test.selfEsteemQuestions:
              return QuestionCard(
                question: questions.qSelfEsteemQuestions[index - 1],
                index: index,
                answers: answer.aSelfEsteemQuestions,
                test: Test.selfEsteemQuestions,
              );
          }
        },
      ),
    );
  }
}
