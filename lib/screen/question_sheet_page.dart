import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/provider/questions_provider.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/color_disposition_subtitle_components.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/guestion_card_color_disposition.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/pitr_card.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/self_leader_diagnosis_subtitle_components.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/test_Question_Page_Selector_Util.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsSheetPage extends ConsumerStatefulWidget {
  static String get routeName => 'QuestionsSheet';
  final String title;

  const QuestionsSheetPage({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<QuestionsSheetPage> createState() => _StressResponseDiagnosisState();
}

class _StressResponseDiagnosisState extends ConsumerState<QuestionsSheetPage> {
  Widget? subTitle;
  Widget? explanations;
  final TestQuestionPageSelectorUtil _pageSelectorUtil = TestQuestionPageSelectorUtil();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  Future<void> init() async {
    String? questionPage = _pageSelectorUtil.testsRouteSelector(widget.title)!;
    await ref.read(questionListProvider.notifier).selectQuestionSheet(questionPage);
    setSubWidgets(questionPage);
    await ref.read(questionListProvider.notifier).getAllQuestions();
    final questions = ref.read(questionListProvider);
    if (questions is QuestionsModel) {
      initAnswerSheet(questions.questions.length);
    }
  }

  void setSubWidgets(String? pageName) {
    if (pageName == GoogleSheetInfo.leadershipQuestions) {
      subTitle = SelfTestDiagnosisPageComponent.subtitle;
      explanations = SelfTestDiagnosisPageComponent.explanations;
    }
    if (pageName == GoogleSheetInfo.colorDispositionChecklist) {
      subTitle = ColorDispositionSubtitleComponents.subtitle;
    }
  }

  Future<void> initAnswerSheet(int listLength) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? data = prefs.getStringList(widget.title);
    if (data != null) {
      ref.read(answerSheetProvider.notifier).initializeFromList(data);
    } else {
      ref.read(answerSheetProvider.notifier).initialize(listLength);
      if (widget.title == testsName[4]) {
        ref.read(answerSheetProvider.notifier).updateAllAnswersByValue('B');
      }
    }
  }

  void saveAnswersAtLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String?> answerList = ref.read(answerSheetProvider).answers;
    List<String> nonNullableAnswerList = answerList.map((e) => e ?? '').toList();
    prefs.setStringList(widget.title, nonNullableAnswerList);
  }

  Future<int> setQuestionQty(List<QuestionModel> questions) async {
    if (questions[0].answerC == '') {
      return 2;
    }
    if (questions[0].answerD == '') {
      return 3;
    }
    if (questions[0].answerE == '') {
      return 4;
    }
    if (questions[0].answerF != '') {
      return 6;
    }
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    final questionsData = ref.watch(questionListProvider);
    final Size size = MediaQuery.of(context).size;

    if (questionsData is QuestionModelsLoading) {
      return DefaultLayout(
        child: Stack(
          children: [
            Positioned(
              bottom: size.height / 7,
              left: size.width / 2 - 50,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (questionsData is QuestionModelsError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            questionsData.error,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    questionsData as QuestionsModel;
    final List<QuestionModel> questions = questionsData.questions;
    int questionLength = questions.length;
    print('questionsLength is $questionLength');
    if (widget.title == 'Color Disposition Checklist') {
      questionLength = 20;
    }

    return Scaffold(
      body: FutureBuilder(
          future: setQuestionQty(questions),
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done
              ? ListView.builder(
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
                              widget.title,
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (subTitle != null) subTitle!,
                          const SizedBox(height: 8),
                          if (explanations != null) explanations!,
                        ],
                      );
                    }

                    if (index == questionLength + 1) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!ref.read(answerSheetProvider).answers.contains(null)) {
                              if (widget.title == 'Color Disposition Checklist' && !colorDispositionValidator()) {
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
                              } else {
                                saveAnswersAtLocal();
                                context.goNamed(
                                  ResultPage.routeName,
                                );
                              }
                            } else {
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
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              '제출하기',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return widget.title == testsName[4]
                        ? widget.title == testsName[5]
                            ? PitrCard(questions: questionsData.questions[index - 1], index: index)
                            : ColorDispositionQuestionCard(
                                questions: [
                                  questionsData.questions[index - 1],
                                  questionsData.questions[(index + 20) - 1],
                                  questionsData.questions[(index + 40) - 1],
                                  questionsData.questions[(index + 60) - 1],
                                ],
                                index: index,
                                questionQty: snapshot.data!,
                              )
                        : QuestionCard(
                            questions: questionsData.questions[index - 1],
                            index: index,
                            questionQty: snapshot.data!,
                          );
                  },
                )
              : Container()),
    );
  }

  bool colorDispositionValidator() {
    final List<String?> result = ref.read(answerSheetProvider).answers;
    bool isValid = false;
    for (int i = 0; i < 20; i++) {
      final List<String?> toBeValidated = [
        result[i],
        result[i + 20],
        result[i + 40],
        result[i + 60],
      ];
      int count = 0;
      for (var i in toBeValidated) {
        if (i == 'B') {
          count++;
        }
      }
      if (count > 2) {
        break;
      }

      if (i == 19) {
        isValid = true;
      }
    }
    return isValid;
  }
}
