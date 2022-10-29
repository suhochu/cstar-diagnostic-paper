import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/provider/questions_provider.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/custom_container.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestSelectionPage extends ConsumerWidget {
  static String get routeName => 'TestSelectionPage';

  TestSelectionPage({super.key});

  final List<String> tests = [];


  void init(WidgetRef ref) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(questionListProvider.notifier).reset();
      ref.read(answerSheetProvider.notifier).reset();
    });
  }

  Future<void> loadClassInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final classInfo = prefs.getStringList('class');
    final accessibleTests = stringToList(classInfo![2], subtract: true);
    tests.clear();
    tests.addAll(accessibleTests);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    init(ref);
    return Scaffold(
      body: FutureBuilder(
        future: loadClassInfo(),
        builder:  (context, snapshot) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: tests.length + 1,
            itemBuilder: (context, index) {
              if(index == tests.length) {
                return Column(
                  children: [
                    const SizedBox(height: 36),
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


              return CustomContainer(
              title: tests[index],
              number: index + 1,
              questionQty: tests.isEmpty ? 4 : tests.length,
            );
            },
          ),
        ),
      ),
    );
  }
}
