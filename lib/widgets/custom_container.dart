import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

class CustomContainer extends ConsumerWidget {
  const CustomContainer({
    super.key,
    required this.qAndAData,
    required this.number,
  });
  final int number;
  final QAndAData qAndAData;




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          ref.read(answerSheetProvider.notifier).addTest(qAndAData.test);
           context.pushNamed('NewQuestionsSheet', extra: qAndAData.test);
          // Navigator.of(context).pushNamed('/NewQuestionsSheet', arguments: qAndAData.test);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white38,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.redAccent),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  number.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                Text(
                  qAndAData.test.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
