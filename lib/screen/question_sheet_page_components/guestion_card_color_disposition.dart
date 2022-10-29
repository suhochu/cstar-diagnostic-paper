import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorDispositionQuestionCard extends ConsumerStatefulWidget {
  const ColorDispositionQuestionCard({
    Key? key,
    required this.questions,
    required this.index,
    this.questionQty = 6,
  }) : super(key: key);
  final List<QuestionModel> questions;
  final int index;
  final int questionQty;

  @override
  ConsumerState<ColorDispositionQuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<ColorDispositionQuestionCard> {
  List<bool> areChecked = [false, false, false, false];
  Selections? selectedValue;

  void _setValues(int index) {
    final List<String?> answerSheet = ref.read(answerSheetProvider).answers;
    if (answerSheet.isNotEmpty) {
      for (int i = 0; i < 4; i++) {
        final answer = answerSheet[index + 20 * i - 1];
        if (answer == 'A') {
          areChecked[i] = true;
        } else {
          areChecked[i] = false;
        }
      }
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            CustomCheckBox(
              text: widget.questions[0].question,
              ref: ref,
              index: widget.index - 1,
              initialValue: areChecked[0],
            ),
            const SizedBox(height: 10),
            CustomCheckBox(
              text: widget.questions[1].question,
              ref: ref,
              index: widget.index + 20 - 1,
              initialValue: areChecked[1],
            ),
            const SizedBox(height: 10),
            CustomCheckBox(
              text: widget.questions[2].question,
              ref: ref,
              index: widget.index + 40 - 1,
              initialValue: areChecked[2],
            ),
            const SizedBox(height: 10),
            CustomCheckBox(
              text: widget.questions[3].question,
              ref: ref,
              index: widget.index + 60 - 1,
              initialValue: areChecked[3],
            ),
          ],
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
          width: 200,
          child: CheckboxListTile(
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            value: value,
            selected: value,
            activeColor: Colors.redAccent,
            onChanged: (value) {
              setValues(value!);
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
