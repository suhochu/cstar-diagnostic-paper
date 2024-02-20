import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class PitrCard extends StatelessWidget {
  PitrCard({
    super.key,
    required this.questions,
    required this.index,
    required this.test,
    this.questionQty = 6,
  });

  final String questions;
  final int index;
  final int questionQty;
  final Test test;

  Selections? selectedValue;

  Future<bool> _readValues(int index) async {
    final List<String> answers = await SharedPreferenceUtil.getStringList(key: Test.pitr.name);

    final answer = answers[index];
    if (answer == Selections.A.toString()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _readValues(index),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: questionTitleWidget(index, snapshot.hasData ? snapshot.data! : false),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget questionTitleWidget(int index, bool initialValue) {
    // _setValues(index);
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            'Q${index + 1}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        // const SizedBox(width: 5),
        CustomCheckBox(
          text: questions,
          // ref: ref,
          index: index,
          initialValue: initialValue,
          test: test,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    super.key,
    required this.text,
    // required this.ref,
    required this.index,
    required this.initialValue,
    required this.test,
  });

  final String text;
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);
  final int index;
  final bool initialValue;
  final Test test;

  // final WidgetRef ref;

  void setValues(bool check) async {
    Selections value;
    if (check) {
      value = Selections.A;
    } else {
      value = Selections.ndf;
    }
    List<String> answers = await SharedPreferenceUtil.getStringList(key: Test.pitr.name);
    answers[index] = value.toString();
    await SharedPreferenceUtil.saveStringList(key: Test.pitr.name, data: answers);
  }

  @override
  Widget build(BuildContext context) {
    _isChecked.value = initialValue;
    return ValueListenableBuilder(
      valueListenable: _isChecked,
      builder: (BuildContext context, bool value, Widget? child) {
        return SizedBox(
          width: 330,
          child: CheckboxListTile(
            value: value,
            dense: true,
            selected: value,
            activeColor: Colors.redAccent,
            onChanged: (value) async {
              setValues(value!);
              _isChecked.value = !_isChecked.value;
            },
            title: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
