import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionCard extends ConsumerStatefulWidget {
  const QuestionCard({
    Key? key,
    required this.questions,
    required this.index,
    this.questionQty = 4,
  }) : super(key: key);
  final QuestionModel questions;
  final int index;
  final int questionQty;

  @override
  ConsumerState<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard> {
  Selections? selectedValue;

  Selections? _setValues() {
    final List<String?> answerSheet = ref.read(answerSheetProvider).answers;
    Selections? selection;
    if (answerSheet.isNotEmpty) {
      final String? value = answerSheet[widget.index - 1];

      if (value != null) {
        selection = stringToSelections(answerSheet[widget.index - 1]!)!;
      }
    }
    return selection;
  }

  RadioListTile _getRadioTile(Selections selected, String content) {
    selectedValue = _setValues();
    return RadioListTile(
      value: selected,
      groupValue: selectedValue,
      contentPadding: const EdgeInsets.only(left: 20),
      activeColor: Colors.redAccent,
      title: Wrap(
        direction: Axis.horizontal,
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      onChanged: (value) {
        setState(() {
          ref.read(answerSheetProvider.notifier).update(widget.index - 1, value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Q${widget.index}.',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      widget.questions.question,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            _getRadioTile(Selections.A, widget.questions.answerA),
            _getRadioTile(Selections.B, widget.questions.answerB),
            if (widget.questionQty >= 3 && widget.questions.answerC != '') _getRadioTile(Selections.C, widget.questions.answerC!),
            if (widget.questionQty >= 4) _getRadioTile(Selections.D, widget.questions.answerD!),
            if (widget.questionQty >= 5) _getRadioTile(Selections.E, widget.questions.answerE!),
            if (widget.questionQty >= 6) _getRadioTile(Selections.F, widget.questions.answerF!),
          ],
        ),
      ),
    );
  }
}
