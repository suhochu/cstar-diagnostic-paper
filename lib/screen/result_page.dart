import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatelessWidget {
  static String get routeName => 'ResultPage';
  final List<String> classInfo = [];
  final List<String> userInfo = [];
  final List<AnswerSheetModel> answersSheets = [];

  ResultPage({Key? key}) : super(key: key);

  Future<void> loadData() async {
    print('load Data Entered');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    classInfo.addAll(prefs.getStringList('class') ?? []);
    print(classInfo);

    userInfo.addAll(prefs.getStringList('user') ?? []);
    print(userInfo);

    final List testTitles = stringToList(classInfo[2], subtract: true);
    print(testTitles);

    for (String title in testTitles) {
      if (prefs.getStringList(title) == null) {
        print('$title is null');
      } else {
        print('$title contents is');
        print(prefs.getStringList(title));

        final AnswerSheetModel answerSheet = AnswerSheetModel(
          answers: prefs.getStringList(title)!,
          title: title,
        );
        answersSheets.add(answerSheet);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: loadData(),
        builder:(context, snapshot) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            _getInfo(
              screenWidth,
              classInfo.toString(),
            ),
            _getInfo(
              screenWidth,
              userInfo.toString(),
            ),
            const SizedBox(
              height: 36,
            ),
            CustomSizedBox(
                child: CustomElevatedButton(
              text: '테스트지 선택 화면으로 이동',
              function: () {},
            )),
            const SizedBox(
              height: 36,
            ),
            CustomSizedBox(
                child: CustomElevatedButton(
              text: 'E-mail 로 보내기',
              function: () {},
            )),
            const SizedBox(
              height: 36,
            ),
            CustomSizedBox(
                child: CustomElevatedButton(
              text: '종료',
              function: () {},
            )),
          ],
        ),
      ),
    );
  }

  Widget _getInfo(double screenWidth, String text) {
    return Container(
      width: screenWidth * 0.7,
      height: 100,
      color: Colors.white38,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
