import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class ColorDispositionQuestionCard extends StatelessWidget {
  ColorDispositionQuestionCard({
    super.key,
    required this.questions,
    required this.index,
    this.questionQty = 6,
  });

  final List<String> questions;
  final int index;
  final int questionQty;
  final List<bool> areChecked = [false, false, false, false];

  Future<bool> _setValues() async {
    final List<String> answers = await SharedPreferenceUtil.getStringList(key: Test.colorDisposition.name);
    if (answers.isEmpty) {
      await SharedPreferenceUtil.saveStringList(key: Test.colorDisposition.name, data: List.generate(80, (index) => Selections.ndf.name));
      return false;
    } else {
      for (int i = 0; i < 4; i++) {
        final answer = answers[index + 20 * i - 1];
        if (answer == Selections.A.name) {
          areChecked[i] = true;
        } else {
          areChecked[i] = false;
        }
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), child: questionTitleWidget()),
      ),
    );
  }

  Widget questionTitleWidget() {
    return FutureBuilder(
      future: _setValues(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  'Q$index',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  CustomCheckBox(
                    text: questions[0],
                    // ref: ref,
                    index: index - 1,
                    initialValue: areChecked[0],
                  ),
                  const SizedBox(height: 10),
                  CustomCheckBox(
                    text: questions[1],
                    // ref: ref,
                    index: index + 20 - 1,
                    initialValue: areChecked[1],
                  ),
                  const SizedBox(height: 10),
                  CustomCheckBox(
                    text: questions[2],
                    // ref: ref,
                    index: index + 40 - 1,
                    initialValue: areChecked[2],
                  ),
                  const SizedBox(height: 10),
                  CustomCheckBox(
                    text: questions[3],
                    // ref: ref,
                    index: index + 60 - 1,
                    initialValue: areChecked[3],
                  ),
                ],
              ),
              const SizedBox(width: 30),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    super.key,
    required this.text,
    required this.index,
    required this.initialValue,
  });

  final String text;
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);
  final int index;
  final bool initialValue;

  Future<void> setValue({required bool result}) async {
    List<String> answers = await SharedPreferenceUtil.getStringList(key: Test.colorDisposition.name);
    if (result) {
      answers[index] = Selections.A.name;
    } else {
      answers[index] = Selections.B.name;
    }
    await SharedPreferenceUtil.saveStringList(key: Test.colorDisposition.name, data: answers);
  }

  @override
  Widget build(BuildContext context) {
    _isChecked.value = initialValue;
    return ValueListenableBuilder(
      valueListenable: _isChecked,
      builder: (BuildContext context, bool value, Widget? child) {
        return SizedBox(
          width: 250,
          child: CheckboxListTile(
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            value: value,
            selected: value,
            activeColor: Colors.redAccent,
            onChanged: (value) async {
              await setValue(result: value!);
              _isChecked.value = !_isChecked.value;
            },
            title: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
