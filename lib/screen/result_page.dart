import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/provider/new_user_provider.dart';
import 'package:cstarimage_testpage/screen/result_page_components/color_disposition_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/disposition_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/eic_image_self_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/personal_color_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/pitr_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/self_esteem_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/self_leadership_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/streess_diagnosis.dart';
import 'package:cstarimage_testpage/screen/selections/diaganosis_selection_page.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/answer_sheet_provider.dart';

class ResultPage extends ConsumerWidget {
  static String get routeName => 'ResultPage';

  ResultPage({Key? key}) : super(key: key);

  late final List<SelfLeaderShipResultModel> selfLeaderShipResult = [];
  late final List<StressDiagnosisResultModel> stressDiagnosisResult = [];
  late int selfEsteemScore = 0;
  late final List<EicDiagnosisResultModel> eicDiagnosisResult = [];
  late final List<int> colorDispositionCheckResult = [];
  late final List<int> pitrCheckResult = [];
  late final List<int> personalColorResult = [];
  DispositionResultModel? disposition1Result;

  Future<void> testResultCalculator({
    required List<AnswerSheetModel> allAnswers,
  }) async {
    final List<Test?> tests = allAnswers.map((e) => e.test).toList();

    if (tests.contains(Test.stressResponseQuestions)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.stressResponseQuestions);
      stressDiagnosisResult.clear();
      stressDiagnosisResult.addAll(StressDiagnosisResult.diagnosis(allAnswers[index]));
    }

    if (tests.contains(Test.selfEsteemQuestions)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.selfEsteemQuestions);
      selfEsteemScore = 0;
      selfEsteemScore = SelfEsteemResult.diagnosis(allAnswers[index]);
    }

    if (tests.contains(Test.leadershipQuestions)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.leadershipQuestions);
      selfLeaderShipResult.clear();
      selfLeaderShipResult.addAll(SelfLeaderShipResult.diagnosis(allAnswers[index]));
    }

    if (tests.contains(Test.eicImage)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.eicImage);
      eicDiagnosisResult.clear();
      eicDiagnosisResult.addAll(EicTypeResult.diagnosis(allAnswers[index]));
    }

    if (tests.contains(Test.colorDisposition)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.colorDisposition);
      colorDispositionCheckResult.clear();
      colorDispositionCheckResult.addAll(ColorDispositionCheckResult.diagnosis(allAnswers[index]));
    }

    if (tests.contains(Test.pitr)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.pitr);
      pitrCheckResult.clear();
      pitrCheckResult.addAll(PITRCheckResult.diagnosis(allAnswers[index]));
    }

    if (tests.contains(Test.dispositionTest)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.dispositionTest);
      disposition1Result = DispositionDiagnosisResult.diagnosis(allAnswers[index]);
    }

    if (tests.contains(Test.personalColorSelfTest)) {
      final int index = allAnswers.indexWhere((element) => element.test == Test.personalColorSelfTest);
      personalColorResult.clear();
      personalColorResult.addAll(PersonalColorDiagnosisResult.diagnosis(allAnswers[index]));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    testResultCalculator(allAnswers: ref.read(answerSheetProvider).allAnswers);
    final userName = ref.read(newUserProvider).name;
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(DiagnosisSelectionPage.routeName);
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 36),
              const Row(),
              if (stressDiagnosisResult.isNotEmpty)
                StressDiagnosisResult.buildWidget(
                  stressDiagnosisResult: stressDiagnosisResult,
                  context: context,
                  userName: userName,
                  score: StressDiagnosisResult.score,
                ),
              if (stressDiagnosisResult.isNotEmpty) const SizedBox(height: 16),
              if (selfEsteemScore != 0)
                SelfEsteemResult.buildWidget(
                  context: context,
                  userName: userName,
                  score: selfEsteemScore,
                ),
              if (selfEsteemScore != 0) const SizedBox(height: 16),
              if (selfLeaderShipResult.isNotEmpty)
                SelfLeaderShipResult.buildWidget(
                  selfLeaderShipResult: selfLeaderShipResult,
                  context: context,
                  userName: userName,
                  score: SelfLeaderShipResult.score,
                ),
              if (selfLeaderShipResult.isNotEmpty) const SizedBox(height: 8),
              if (eicDiagnosisResult.isNotEmpty)
                EicTypeResult.buildWidget(
                  eicDiagnosisResult: eicDiagnosisResult,
                  context: context,
                  userName: userName,
                  score: EicTypeResult.score,
                ),
              if (eicDiagnosisResult.isNotEmpty) const SizedBox(height: 8),
              if (colorDispositionCheckResult.isNotEmpty)
                ColorDispositionCheckResult.buildWidget(
                  colorDispositionResult: colorDispositionCheckResult,
                  context: context,
                  userName: userName,
                ),
              if (colorDispositionCheckResult.isNotEmpty) const SizedBox(height: 8),
              if (pitrCheckResult.isNotEmpty)
                PITRCheckResult.buildWidget(
                  pitrResult: pitrCheckResult,
                  context: context,
                  userName: userName,
                ),
              if (pitrCheckResult.isNotEmpty) const SizedBox(height: 8),
              if (disposition1Result != null)
                DispositionDiagnosisResult.buildWidget(
                  dispositionResult: disposition1Result!,
                  context: context,
                  userName: userName,
                ),
              if (disposition1Result != null) const SizedBox(height: 8),
              if (personalColorResult.isNotEmpty)
                PersonalColorDiagnosisResult.buildWidget(
                  score: personalColorResult,
                  context: context,
                  userName: userName,
                ),
              const SizedBox(height: 36),
              CustomSizedBox(
                child: CustomElevatedButton(
                  text: '테스트지 선택 화면으로 이동',
                  function: () => context.goNamed(DiagnosisSelectionPage.routeName),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
