import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/provider/questions_provider.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/self_test_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page_components/test_Question_Page_Selector_Util.dart';
import 'package:cstarimage_testpage/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsSheetPage extends ConsumerStatefulWidget {
  static String get routeName => 'QuestionsSheet';
  final String title;

  // final int questionQty;

  const QuestionsSheetPage({
    super.key,
    required this.title,
    // required this.questionQty,
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
  }

  void setSubWidgets(String? pageName) {
    if (pageName == GoogleSheetInfo.leadershipQuestions) {
      subTitle = SelfTestDiagnosisPageComponent.subtitle;
      explanations = SelfTestDiagnosisPageComponent.explanations;
    }
  }

  void initAnswerSheet(int listLength) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(answerSheetProvider.notifier).initialize(listLength);
    });
  }

  void saveAnswersAtLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String?> answerList = ref.read(answerSheetProvider).answers;
    List<String> nonNullableAnswerList = answerList.map((e) => e ?? '').toList();
    prefs.setStringList(widget.title, nonNullableAnswerList);
  }

  int setQuestionQty(List<QuestionModel> questions) {
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
    print('build');
    final questionsData = ref.watch(questionListProvider);
    if (questionsData is QuestionModelsLoading) {
      return const Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        ),
      );
    }
    if (questionsData is QuestionModelsError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            questionsData.error,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    questionsData as QuestionsModel;
    final List<QuestionModel> questions = questionsData.questions;
    initAnswerSheet(questions.length);
    int questionQty = setQuestionQty(questions);
    return Scaffold(
      body: ListView.builder(
        itemCount: questions.length + 2,
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
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                ),
                if (subTitle != null) subTitle!,
                const SizedBox(height: 16),
                if (explanations != null) explanations!,
              ],
            );
          }

          if (index == questions.length + 1) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (!ref.read(answerSheetProvider).answers.contains(null)) {
                    saveAnswersAtLocal();
                    context.goNamed(
                      ResultPage.routeName,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(
                          '선택 안된 항목이 있습니다. 전부 작성 부탁드립니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
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
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }
          return QuestionCard(
            questions: questionsData.questions[index - 1],
            index: index,
            questionQty: questionQty,
          );
        },
      ),
    );
  }
}

