import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PitrCard extends ConsumerStatefulWidget {
  const PitrCard({
    Key? key,
    required this.questions,
    required this.index,
    required this.test,
    this.questionQty = 6,
  }) : super(key: key);
  final String questions;
  final int index;
  final int questionQty;
  final Test test;

  @override
  ConsumerState<PitrCard> createState() => _PitrCardState();
}

class _PitrCardState extends ConsumerState<PitrCard> {
  bool isChecked = false;
  Selections? selectedValue;

  void _setValues(int index) {
    final List<Selections> answerSheet = ref.read(answerSheetProvider.notifier).returnSelectionsList(widget.test);
    final answer = answerSheet[index];
    if (answer == Selections.A) {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              child: questionTitleWidget(widget.index),
            ),
          ),
        ],
      ),
    );
  }

  Widget questionTitleWidget(int index) {
    _setValues(index);
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            'Q${widget.index + 1}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        // const SizedBox(width: 5),
        CustomCheckBox(
          text: widget.questions,
          ref: ref,
          index: widget.index,
          initialValue: isChecked,
          test: widget.test,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    Key? key,
    required this.text,
    required this.ref,
    required this.index,
    required this.initialValue,
    required this.test,
  }) : super(key: key);
  final String text;
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);
  final int index;
  final bool initialValue;
  final Test test;
  final WidgetRef ref;

  void setValues(bool check) async {
    Selections value;
    if (check) {
      value = Selections.A;
    } else {
      value = Selections.ndf;
    }
    ref.read(answerSheetProvider.notifier).update(index: index, selection: value, test: test);
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
            onChanged: (value) {
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
