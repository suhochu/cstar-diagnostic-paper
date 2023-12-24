import 'package:cstarimage_testpage/data/color_disposition.dart';
import 'package:cstarimage_testpage/data/disposition_test.dart';
import 'package:cstarimage_testpage/data/eic_image.dart';
import 'package:cstarimage_testpage/data/leadership_questions.dart';
import 'package:cstarimage_testpage/data/personal_color_self.dart';
import 'package:cstarimage_testpage/data/pitr.dart';
import 'package:cstarimage_testpage/data/self_esteem_questions.dart';
import 'package:cstarimage_testpage/data/stress_response_questions.dart';
import 'package:cstarimage_testpage/provider/new_user_provider.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

import '../../model/questions_answers_data.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/sizedbox.dart';

class DiagnosisSelectionPage extends ConsumerWidget {
  const DiagnosisSelectionPage({super.key});

  List<QAndAData> getQList({required String code}) {
    final List<QAndAData> qList = [];
    final String subCode = code.substring(8);
    if (subCode.contains('c')) qList.add(ColorDisposition());
    if (subCode.contains('d')) qList.add(DispositionTest());
    if (subCode.contains('e')) qList.add(EicImage());
    if (subCode.contains('l')) qList.add(LeadershipQuestions());
    if (subCode.contains('n')) qList.add(PersonalColorSelfTest());
    if (subCode.contains('p')) qList.add(Pitr());
    if (subCode.contains('s')) qList.add(SelfEsteemQuestions());
    if (subCode.contains('r')) qList.add(StressResponseQuestions());
    return qList;
    // return NewUserModel(name: name, code: code, testList: qList);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<QAndAData> diagnosisList = getQList(code: ref.read(newUserProvider).code);

    return WillPopScope(
      onWillPop: () async {
        context.pushNamed('/');
        // Navigator.of(context).pushNamed("/");
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${ref.read(newUserProvider).name}님 강의에 참여해 주셔서 감사합니다.',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: diagnosisList.length + 2,
            itemBuilder: (context, index) {
              if (index == diagnosisList.length) {
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    CustomSizedBox(
                        child: CustomElevatedButton(
                      text: '결과 화면으로 이동',
                      function: () {
                        // Navigator.of(context).pushNamed("/ResultPage");
                        context.goNamed('ResultPage');
                      },
                    )),
                  ],
                );
              }
              if (index == diagnosisList.length + 1) {
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    CustomSizedBox(
                      child: CustomElevatedButton(
                        text: '강의 코드 입력 화면 으로 이동',
                        function: () {
                          // Navigator.of(context).pushNamed("/");
                          context.goNamed('/');
                        },
                      ),
                    ),
                  ],
                );
              }
              return CustomContainer(
                qAndAData: diagnosisList[index],
                number: index + 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
