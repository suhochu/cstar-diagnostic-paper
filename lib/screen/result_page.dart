import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultPage extends ConsumerStatefulWidget {
  static String get routeName => 'ResultPage';

  final int totalQuestionQty;

  const ResultPage({Key? key, required this.totalQuestionQty}) : super(key: key);

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  void init() {
    // ref.read(answerSheetProvider.notifier).initialize(widget.totalQuestionQty);
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.read(answerSheetProvider);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          _getInfo(screenWidth, result.answerSheet.toString(),),
          _getInfo(screenWidth, result.userEmail.toString(),),
          _getInfo(screenWidth, result.userName.toString(),),
          _getInfo(screenWidth, result.testDate.toString(),),
          _getInfo(screenWidth, result.company.toString(),),
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
    );
  }

  Widget _getInfo(double screenWidth, String text){
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
