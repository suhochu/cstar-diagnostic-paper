import 'package:cstarimage_testpage/provider/new_user_provider.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/questions_answers_data.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/sizedbox.dart';
import '../code_insert/code_insert_page.dart';

class DiagnosisSelectionPage extends ConsumerWidget {
  const DiagnosisSelectionPage({super.key});

  static String get routeName => 'diagnosisSelectionPage';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<QAndAData> diagnosisList = ref.read(newUserProvider).testList;
    return WillPopScope(
      onWillPop: () async {
        context.pushNamed(CodeInsertPage.routeName);
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
                        context.goNamed(ResultPage.routeName);
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
