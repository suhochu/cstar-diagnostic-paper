import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PitrCard extends ConsumerStatefulWidget {
  const PitrCard({
    Key? key,
    required this.questions,
    required this.index,
    this.questionQty = 6,
  }) : super(key: key);
  final QuestionModel questions;
  final int index;
  final int questionQty;

  @override
  ConsumerState<PitrCard> createState() => _PitrCardState();
}

class _PitrCardState extends ConsumerState<PitrCard> {
  bool isChecked = false;
  Selections? selectedValue;

  void _setValues(int index) {
    final List<String?> answerSheet = ref.read(answerSheetProvider).answers;
    final answer = answerSheet[index - 1];
    if (answer == 'A') {
      isChecked = true;
    } else {
      isChecked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: questionTitleWidget(widget.index)),
      ),
    );
  }

  Widget questionTitleWidget(int index) {
    _setValues(index);
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            'Q${widget.index}.',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        CustomCheckBox(
          text: widget.questions.question,
          ref: ref,
          index: widget.index - 1,
          initialValue: isChecked,
        ),
        const SizedBox(
          width: 30,
        ),
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
  }) : super(key: key);
  final String text;
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);
  final int index;
  final bool initialValue;
  final WidgetRef ref;

  void setValues(bool check) async {
    Selections value;
    if (check) {
      value = Selections.A;
    } else {
      value = Selections.B;
    }
    ref.read(answerSheetProvider.notifier).update(index, value);
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
            value: value,
            selected: value,
            activeColor: Colors.redAccent,
            onChanged: (value) {
              setValues(value!);
              _isChecked.value = !_isChecked.value;
            },
            title: Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
