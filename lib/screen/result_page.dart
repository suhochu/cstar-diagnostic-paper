import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/screen/result_page_components/color_disposition_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/eic_image_self_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/pitr_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/self_esteem_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/streess_diagnosis.dart';
import 'package:cstarimage_testpage/screen/result_page_components/self_leadership_diagnosis.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatelessWidget {
  static String get routeName => 'ResultPage';
  final List<SelfLeaderShipResultModel> selfLeaderShipResult = [];
  final List<StressDiagnosisResultModel> stressDiagnosisResult = [];
  int selfEsteemScore = 0;
  final List<EicDiagnosisResultModel> eicDiagnosisResult = [];
  final List<int> colorDispositionCheckResult = [];
  final List<int> pitrCheckResult = [];
  late final UserModel userModel;
  late final ClassModel classModel;

  ResultPage({Key? key}) : super(key: key);

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //클래스 데이터 불러오기
    List<String> classInfo = [];
    classInfo.addAll(prefs.getStringList('class') ?? []);
    classModel = ClassModel.fromList(classInfo);

    //유저 데이터 불러오기
    List<String> userInfo = [];
    userInfo.addAll(prefs.getStringList('user') ?? []);
    userModel = UserModel.fromList(userInfo);

    //클래스 데이터에서 그날 예정인 테스트 불러오기
    for (String title in classModel.accessibleTests) {
      //테스트에 대한 결과가 있으면 AnswerSheetModel 을 만들어서 반환

      if (prefs.getStringList(title) != null) {
        print('title is $title');
        print('enter here');
        final AnswerSheetModel answerSheet = AnswerSheetModel(
          answers: prefs.getStringList(title)!,
          title: title,
        );

        testResultCalculator(title: title, answerSheet: answerSheet);
      }
    }
  }

  void testResultCalculator({
    required String title,
    required AnswerSheetModel answerSheet,
  }) {
    if (title == testsName[0]) {
      stressDiagnosisResult.clear();
      stressDiagnosisResult.addAll(StressDiagnosisResult.diagnosis(answerSheet));
    }

    if (title == testsName[1]) {
      selfEsteemScore = 0;
      selfEsteemScore = SelfEsteemResult.diagnosis(answerSheet);
    }

    if (title == testsName[2]) {
      selfLeaderShipResult.clear();
      selfLeaderShipResult.addAll(SelfLeaderShipResult.diagnosis(answerSheet));
    }

    if (title == testsName[3]) {
      eicDiagnosisResult.clear();
      eicDiagnosisResult.addAll(EicTypeResult.diagnosis(answerSheet));
    }

    if (title == testsName[4]) {
      colorDispositionCheckResult.clear();
      colorDispositionCheckResult.addAll(ColorDispositionCheckResult.diagnosis(answerSheet));
    }

    if (title == testsName[5]) {
      pitrCheckResult.clear();
      pitrCheckResult.addAll(PITRCheckResult.diagnosis(answerSheet));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(),
              if (stressDiagnosisResult.isNotEmpty)
                StressDiagnosisResult.buildWidget(
                  stressDiagnosisResult: stressDiagnosisResult,
                  context: context,
                  userName: userModel.name,
                  score: StressDiagnosisResult.score,
                ),
              if (selfEsteemScore != 0)
                SelfEsteemResult.buildWidget(context: context, userName: userModel.name, score: selfEsteemScore),
              if (selfLeaderShipResult.isNotEmpty)
                SelfLeaderShipResult.buildWidget(
                  selfLeaderShipResult: selfLeaderShipResult,
                  context: context,
                  userName: userModel.name,
                  score: SelfLeaderShipResult.score,
                ),
              if (eicDiagnosisResult.isNotEmpty)
                EicTypeResult.buildWidget(
                  eicDiagnosisResult: eicDiagnosisResult,
                  context: context,
                  userName: userModel.name,
                  score: EicTypeResult.score,
                ),
              if (colorDispositionCheckResult.isNotEmpty)
                ColorDispositionCheckResult.buildWidget(
                  colorDispositionResult: colorDispositionCheckResult,
                  context: context,
                  userName: userModel.name,
                  // score: ColorDispositionCheckResult.score,
                ),
              if (pitrCheckResult.isNotEmpty)
                PITRCheckResult.buildWidget(
                  pitrResult: pitrCheckResult,
                  context: context,
                  userName: userModel.name,
                ),
              const SizedBox(height: 36),
              CustomSizedBox(
                  child: CustomElevatedButton(
                text: '테스트지 선택 화면으로 이동',
                function: () {
                  context.goNamed(TestSelectionPage.routeName);
                },
              )),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
