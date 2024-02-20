import 'package:cstarimage_testpage/constants/answers.dart';
import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/constants/questions.dart';
import 'package:cstarimage_testpage/data/color_disposition.dart' deferred as color_disposition;
import 'package:cstarimage_testpage/data/disposition_test.dart' deferred as disposition_test;
import 'package:cstarimage_testpage/data/eic_image.dart' deferred as eic_image;
import 'package:cstarimage_testpage/data/leadership_questions.dart' deferred as leadership;
import 'package:cstarimage_testpage/data/personal_color_self.dart' deferred as personal_color;
import 'package:cstarimage_testpage/data/pitr.dart' deferred as pitr;
import 'package:cstarimage_testpage/data/self_esteem_questions.dart' deferred as self_esteem;
import 'package:cstarimage_testpage/data/stress_response_questions.dart' deferred as stress_response;
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:cstarimage_testpage/routes/qlevar_routes.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/guestion_card_color_disposition.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/pitr_card.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/question_card.dart';
import 'package:cstarimage_testpage/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
// import 'package:go_router/go_router.dart';

class NewQuestionSheet extends StatelessWidget {
  const NewQuestionSheet({
    super.key,
    required this.test,
  });

  final Test test;

  Future<(QAndAData, int)> selectQAndData() async {
    final QAndAData qAndAData;
    int qNumber = test.lengthOfQuestions();
    await SharedPreferenceUtil.saveStringList(key: test.name, data: List.generate(qNumber, (index) => Selections.ndf.name));
    switch (test) {
      case Test.colorDisposition:
        await color_disposition.loadLibrary();
        qNumber = qNumber ~/ 4;
        qAndAData = color_disposition.ColorDisposition();
        break;
      case Test.dispositionTest:
        await disposition_test.loadLibrary();
        qAndAData = disposition_test.DispositionTest();
        break;
      case Test.eicImage:
        await eic_image.loadLibrary();
        qAndAData = eic_image.EicImage();
        break;
      case Test.leadershipQuestions:
        await leadership.loadLibrary();
        qAndAData = leadership.LeadershipQuestions();
        break;
      case Test.personalColorSelfTest:
        await personal_color.loadLibrary();
        qAndAData = personal_color.PersonalColorSelfTest();
        break;
      case Test.pitr:
        await pitr.loadLibrary();
        qAndAData = pitr.Pitr();
        break;
      case Test.selfEsteemQuestions:
        await self_esteem.loadLibrary();
        qAndAData = self_esteem.SelfEsteemQuestions();
        break;
      case Test.stressResponseQuestions:
        await stress_response.loadLibrary();
        qAndAData = stress_response.StressResponseQuestions();
        break;
    }
    return (qAndAData, qNumber);
  }

  Future<bool> containNdf() async {
    if (test == Test.pitr) return false;
    final List<String> answerList = [];
    answerList.clear();
    answerList.addAll(await SharedPreferenceUtil.getStringList(key: test.name));
    return answerList.contains(Selections.ndf.name);
  }

  void showSnackBar(String contents, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          contents,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectQAndData(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
            body: ListView.builder(
              itemCount: snapshot.data!.$2 + 2,
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
                          snapshot.data!.$1.test.name,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (snapshot.data!.$1.subTitle != null) snapshot.data!.$1.subTitle!,
                      const SizedBox(height: 8),
                      if (snapshot.data!.$1.explanations != null) snapshot.data!.$1.explanations!,
                    ],
                  );
                }

                if (index == snapshot.data!.$2 + 1) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final List<String> answerResult = await SharedPreferenceUtil.getStringList(key: test.name);
                        final (SelectionType, bool, bool) result = (
                          snapshot.data!.$1.selectionType,
                          await containNdf(),
                          answerResult.isNotEmpty ? snapshot.data!.$1.validator(answerResult) : false,
                          //todo Refactor this
                        );
                        switch (result) {
                          case (SelectionType.checkBox, true, false):
                            showSnackBar(
                              '2가지 항목이상 점수를 주신 않은 문항이 있습니다.\n모든 문항에 대해서 2가지 항목 이상에 대해서 1점 이상의 점수를 주세요',
                              context,
                            );
                            break;
                          case (SelectionType.radio, true, _):
                          case (SelectionType.radio, false, false):
                            showSnackBar(
                              '선택 안된 항목이 있습니다. 전부 작성 부탁드립니다.',
                              context,
                            );
                            break;
                          case (_, _, _):
                            // context.goNamed('ResultPage');
                            QR.toName(AppRoutes.resultPage);
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
                switch (snapshot.data!.$1.test) {
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
                return null;
              },
            ),
          );
        }
        return const CircularProgressIndicator(
          color: Colors.transparent,
          value: 10,
        );
      },
    );
  }
}
