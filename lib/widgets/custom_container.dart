import 'package:cstarimage_testpage/screen/question_sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.title, required this.number, required this.questionQty}) : super(key: key);
  final String title;
  final int number;
  final int questionQty;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            QuestionsSheetPage.routeName,
            pathParameters: {'rid': title},
          );
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
                const SizedBox(
                  width: 16,
                ),
                Text(
                  title,
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
