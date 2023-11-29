import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/lecture_code.dart';

class QuestionCard extends ConsumerStatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.index,
    required this.answers,
    required this.test,
  }) : super(key: key);
  final String question;
  final int index;
  final List<String> answers;
  final Test test;

  @override
  ConsumerState<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard> {
  Selections? selectedValue;

  RadioListTile _getRadioTile(Selections selected, String content) {
    selectedValue = ref.read(answerSheetProvider.notifier).returnSelectionsList(widget.test)[widget.index - 1];
    return RadioListTile(
      value: selected,
      groupValue: selectedValue,
      contentPadding: const EdgeInsets.only(left: 20),
      activeColor: Colors.redAccent,
      title: Text(
        content,
        style: const TextStyle(fontSize: 14),
      ),
      onChanged: (value) {
        setState(() {
          ref.read(answerSheetProvider.notifier).update(test: widget.test, index: widget.index - 1, selection: value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    'Q${widget.index}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.question,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            _getRadioTile(Selections.A, widget.answers[0]),
            _getRadioTile(Selections.B, widget.answers[1]),
            if (widget.answers.length >= 3) _getRadioTile(Selections.C, widget.answers[2]),
            if (widget.answers.length >= 4) _getRadioTile(Selections.D, widget.answers[3]),
            if (widget.answers.length >= 5) _getRadioTile(Selections.E, widget.answers[4]),
            if (widget.answers.length >= 6) _getRadioTile(Selections.F, widget.answers[5]),
          ],
        ),
      ),
    );
  }
}
