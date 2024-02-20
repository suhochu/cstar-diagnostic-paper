import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/routes/qlevar_routes.dart';
import 'package:cstarimage_testpage/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

// import 'package:go_router/go_router.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/sizedbox.dart';

class DiagnosisSelectionPage extends StatelessWidget {
  const DiagnosisSelectionPage({super.key});

  // final List<Test> diagnosisList = [];

  Future<({String name, List<Test> qList})> getQList() async {
    //todo Need Refactoring
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String code = prefs.getString('code') ?? '';
    final String code = await SharedPreferenceUtil.getString(key: 'code');
    final List<Test> qList = [];
    // final String subCode = code.substring(8);
    if (code.contains('c')) qList.add(Test.colorDisposition);
    if (code.contains('d')) qList.add(Test.dispositionTest);
    if (code.contains('e')) qList.add(Test.eicImage);
    if (code.contains('l')) qList.add(Test.leadershipQuestions);
    if (code.contains('n')) qList.add(Test.personalColorSelfTest);
    if (code.contains('p')) qList.add(Test.pitr);
    if (code.contains('s')) qList.add(Test.selfEsteemQuestions);
    if (code.contains('r')) qList.add(Test.stressResponseQuestions);
    final String name = await SharedPreferenceUtil.getString(key: 'name');
    // final name = prefs.getString('name') ?? '';
    return (name: name, qList: qList);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        // context.pushNamed('/');
        QR.toName(AppRoutes.rootPage);
      },
      child: FutureBuilder(
        future: getQList(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '${snapshot.data?.name ?? ''}님 강의에 참여해 주셔서 감사합니다.',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                centerTitle: true,
                backgroundColor: Colors.redAccent,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: (snapshot.data?.qList.length ?? 0) + 2,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data?.qList.length) {
                      return Column(
                        children: [
                          const SizedBox(height: 24),
                          CustomSizedBox(
                              child: CustomElevatedButton(
                            text: '결과 화면으로 이동',
                            function: () {
                              // Navigator.of(context).pushNamed("/ResultPage");
                              // context.goNamed('ResultPage');
                              QR.toName(AppRoutes.resultPage);
                            },
                          )),
                        ],
                      );
                    }
                    if (index == (snapshot.data?.qList.length ?? 0) + 1) {
                      return Column(
                        children: [
                          const SizedBox(height: 24),
                          CustomSizedBox(
                            child: CustomElevatedButton(
                              text: '강의 코드 입력 화면 으로 이동',
                              function: () {
                                // Navigator.of(context).pushNamed("/");
                                // context.goNamed('/');
                                QR.toName(AppRoutes.rootPage);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return InkWell(
                      onTap: () {
                        // ref.read(answerSheetProvider.notifier).addTest(qAndAData.test);
                        // context.pushNamed('NewQuestionsSheet', extra: snapshot.data?.qList[index]);
                        final data = snapshot.data?.qList[index];
                        QR.toName(AppRoutes.questionSheet, params: {'testName': data});
                      },
                      child: CustomContainer(
                        name: snapshot.data?.qList[index].name ?? '',
                        number: index + 1,
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator(
              value: 10,
              color: Colors.transparent,
            );
          }
        },
      ),
    );
  }
}
