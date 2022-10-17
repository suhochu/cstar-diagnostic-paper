import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/provider/questions_provider.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/utils/questions_selector.dart';
import 'package:cstarimage_testpage/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QuestionsSheetPage extends ConsumerStatefulWidget {
  static String get routeName => 'QuestionsSheet';
  final String title;
  final int questionQty;

  const QuestionsSheetPage({
    super.key,
    required this.title,
    required this.questionQty,
  });

  @override
  ConsumerState<QuestionsSheetPage> createState() => _StressResponseDiagnosisState();
}

class _StressResponseDiagnosisState extends ConsumerState<QuestionsSheetPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    await ref.read(questionListProvider.notifier).selectQuestionSheet(testsRouteSelector(widget.title)!);
    await ref.read(questionListProvider.notifier).getAllQuestions();
  }

  void initAnswerSheet(int listLength) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(answerSheetProvider.notifier).initialize(listLength);
    });
  }

  @override
  Widget build(BuildContext context) {
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

    final int listLength = questionsData.questions.length;
    initAnswerSheet(listLength);
    return Scaffold(
        body: ListView.builder(
      itemCount: listLength + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(bottom: 8, right: 16),
                child: const Text(
                  "본 진단지 저작권은 '씨스타이미지'에 있습니다.",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
        if (index == listLength + 1) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                context.goNamed(ResultPage.routeName, queryParams: {'totalQty': listLength.toString()});
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
          questionQty: widget.questionQty,
        );
      },
    ));
  }
}
