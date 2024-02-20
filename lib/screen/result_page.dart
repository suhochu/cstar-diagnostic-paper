import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/routes/qlevar_routes.dart';
import 'package:cstarimage_testpage/screen/result_page_components/color_disposition_diagnosis.dart' deferred as color_disposition;
import 'package:cstarimage_testpage/screen/result_page_components/disposition_diagnosis.dart' deferred as disposition;
import 'package:cstarimage_testpage/screen/result_page_components/eic_image_self_diagnosis.dart' deferred as eic;
import 'package:cstarimage_testpage/screen/result_page_components/personal_color_diagnosis.dart' deferred as personal_color;
import 'package:cstarimage_testpage/screen/result_page_components/pitr_diagnosis.dart' deferred as pitr;
import 'package:cstarimage_testpage/screen/result_page_components/self_esteem_diagnosis.dart' deferred as self_esteem;
import 'package:cstarimage_testpage/screen/result_page_components/self_leadership_diagnosis.dart' deferred as self_leadership;
import 'package:cstarimage_testpage/screen/result_page_components/streess_diagnosis.dart' deferred as stress;
import 'package:cstarimage_testpage/utils/shared_preference.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
// import 'package:go_router/go_router.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  late final List<SelfLeaderShipResultModel> selfLeaderShipResult = [];
  late final List<StressDiagnosisResultModel> stressDiagnosisResult = [];
  late int selfEsteemScore = 0;
  late final List<EicDiagnosisResultModel> eicDiagnosisResult = [];
  late final List<int> colorDispositionCheckResult = [];
  late final List<int> pitrCheckResult = [];
  late final List<int> personalColorResult = [];
  late final String userName;
  DispositionResultModel? disposition1Result;
  ResultsAnswer resultsAnswer = ResultsAnswer();

  Future<bool> testResultCalculator() async {
    userName = await SharedPreferenceUtil.getString(key: 'name');

    final Set<String> allTests = await SharedPreferenceUtil.getKeys();

    if (allTests.isNotEmpty) {
      if (allTests.contains(Test.stressResponseQuestions.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.stressResponseQuestions.name);
        await stress.loadLibrary();
        stressDiagnosisResult.clear();
        stressDiagnosisResult.addAll(stress.StressDiagnosisResult.diagnosis(result));
        resultsAnswer = resultsAnswer.copyWith(stress: true);
      }

      if (allTests.contains(Test.selfEsteemQuestions.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.selfEsteemQuestions.name);
        await self_esteem.loadLibrary();
        selfEsteemScore = 0;
        selfEsteemScore = self_esteem.SelfEsteemResult.diagnosis(result);
        resultsAnswer = resultsAnswer.copyWith(selfEsteem: true);
      }

      if (allTests.contains(Test.leadershipQuestions.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.leadershipQuestions.name);
        await self_leadership.loadLibrary();
        selfLeaderShipResult.clear();
        selfLeaderShipResult.addAll(self_leadership.SelfLeaderShipResult.diagnosis(result));
        resultsAnswer = resultsAnswer.copyWith(selfLeadership: true);
      }

      if (allTests.contains(Test.eicImage.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.eicImage.name);
        await eic.loadLibrary();
        eicDiagnosisResult.clear();
        eicDiagnosisResult.addAll(eic.EicTypeResult.diagnosis(result));
        resultsAnswer = resultsAnswer.copyWith(eic: true);
      }

      if (allTests.contains(Test.colorDisposition.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.colorDisposition.name);
        await color_disposition.loadLibrary();
        colorDispositionCheckResult.clear();
        colorDispositionCheckResult.addAll(color_disposition.ColorDispositionCheckResult.diagnosis(result));
        resultsAnswer = resultsAnswer.copyWith(colorDisposition: true);
      }

      if (allTests.contains(Test.pitr.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.pitr.name);
        print('answer sheet of pitr is $result');
        await pitr.loadLibrary();
        pitrCheckResult.clear();
        pitrCheckResult.addAll(pitr.PITRCheckResult.diagnosis(result));
        resultsAnswer = resultsAnswer.copyWith(pitr: true);
      }

      if (allTests.contains(Test.dispositionTest.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.dispositionTest.name);
        await disposition.loadLibrary();
        disposition1Result = disposition.DispositionDiagnosisResult.diagnosis(result);
        resultsAnswer = resultsAnswer.copyWith(disposition: true);
      }

      if (allTests.contains(Test.personalColorSelfTest.name)) {
        final List<String> result = await SharedPreferenceUtil.getStringList(key: Test.personalColorSelfTest.name);
        await personal_color.loadLibrary();
        personalColorResult.clear();
        personalColorResult.addAll(personal_color.PersonalColorDiagnosisResult.diagnosis(result));
        resultsAnswer = resultsAnswer.copyWith(personalColor: true);
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // context.goNamed('diagnosisSelectionPage');
        QR.toName(AppRoutes.testSelectionPage);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: testResultCalculator(),
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 36),
                    const Row(),
                    if (resultsAnswer.stress)
                      stress.StressDiagnosisResult.buildWidget(
                        stressDiagnosisResult: stressDiagnosisResult,
                        context: context,
                        userName: userName,
                        score: stress.StressDiagnosisResult.score,
                      ),
                    if (resultsAnswer.stress) const SizedBox(height: 16),
                    if (resultsAnswer.selfEsteem)
                      self_esteem.SelfEsteemResult.buildWidget(
                        context: context,
                        userName: userName,
                        score: selfEsteemScore,
                      ),
                    if (resultsAnswer.selfEsteem) const SizedBox(height: 16),
                    if (resultsAnswer.selfLeadership)
                      self_leadership.SelfLeaderShipResult.buildWidget(
                        selfLeaderShipResult: selfLeaderShipResult,
                        context: context,
                        userName: userName,
                        score: self_leadership.SelfLeaderShipResult.score,
                      ),
                    if (resultsAnswer.selfLeadership) const SizedBox(height: 8),
                    if (resultsAnswer.eic)
                      eic.EicTypeResult.buildWidget(
                        eicDiagnosisResult: eicDiagnosisResult,
                        context: context,
                        userName: userName,
                        score: eic.EicTypeResult.score,
                      ),
                    if (resultsAnswer.eic) const SizedBox(height: 8),
                    if (resultsAnswer.colorDisposition)
                      color_disposition.ColorDispositionCheckResult.buildWidget(
                        colorDispositionResult: colorDispositionCheckResult,
                        context: context,
                        userName: userName,
                      ),
                    if (resultsAnswer.colorDisposition) const SizedBox(height: 8),
                    if (resultsAnswer.pitr)
                      pitr.PITRCheckResult.buildWidget(
                        pitrResult: pitrCheckResult,
                        context: context,
                        userName: userName,
                      ),
                    if (resultsAnswer.pitr) const SizedBox(height: 8),
                    if (resultsAnswer.disposition)
                      disposition.DispositionDiagnosisResult.buildWidget(
                        dispositionResult: disposition1Result!,
                        context: context,
                        userName: userName,
                      ),
                    if (resultsAnswer.disposition) const SizedBox(height: 8),
                    if (resultsAnswer.personalColor)
                      personal_color.PersonalColorDiagnosisResult.buildWidget(
                        score: personalColorResult,
                        context: context,
                        userName: userName,
                      ),
                    const SizedBox(height: 36),
                    CustomSizedBox(
                      child: CustomElevatedButton(
                        text: '테스트지 선택 화면으로 이동',
                        function: () => QR.toName(AppRoutes.testSelectionPage)
                        // context.goNamed('diagnosisSelectionPage')
                        ,
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                );
              }
              return const Center(
                child: Text('진단이 완료된 테스트가 없습니다.', style: TextStyle(fontSize: 20)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ResultsAnswer {
  final bool colorDisposition;
  final bool disposition;
  final bool eic;
  final bool personalColor;
  final bool pitr;
  final bool selfEsteem;
  final bool selfLeadership;
  final bool stress;

  ResultsAnswer({
    this.colorDisposition = false,
    this.disposition = false,
    this.eic = false,
    this.personalColor = false,
    this.pitr = false,
    this.selfEsteem = false,
    this.selfLeadership = false,
    this.stress = false,
  });

  ResultsAnswer copyWith({
    bool? colorDisposition,
    bool? disposition,
    bool? eic,
    bool? personalColor,
    bool? pitr,
    bool? selfEsteem,
    bool? selfLeadership,
    bool? stress,
  }) {
    return ResultsAnswer(
      colorDisposition: colorDisposition ?? this.colorDisposition,
      disposition: disposition ?? this.disposition,
      eic: eic ?? this.eic,
      personalColor: personalColor ?? this.personalColor,
      pitr: pitr ?? this.pitr,
      selfEsteem: selfEsteem ?? this.selfEsteem,
      selfLeadership: selfLeadership ?? this.selfLeadership,
      stress: stress ?? this.stress,
    );
  }

  ({
    bool colorDisposition,
    bool disposition,
    bool eic,
    bool personalColor,
    bool pitr,
    bool selfEsteem,
    bool selfLeadership,
    bool stress,
  }) listHasInitialized() {
    return (
      colorDisposition: colorDisposition,
      disposition: disposition,
      eic: eic,
      personalColor: personalColor,
      pitr: pitr,
      selfEsteem: selfEsteem,
      selfLeadership: selfLeadership,
      stress: stress,
    );
  }
}
