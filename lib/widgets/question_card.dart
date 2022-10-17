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
    this.questionQty = 4 ,
  }) : super(key: key);
  final QuestionModel questions;
  final int index;
  final int questionQty;

  @override
  ConsumerState<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard> {
  Selections selections = Selections.A;

  RadioListTile _getRadioTile(Selections selected, String content) {
    return RadioListTile(
      value: selected,
      groupValue: selections,
      contentPadding: const EdgeInsets.only(left: 60),
      activeColor: Colors.redAccent,
      title: Text(content),
      onChanged: (value) {
        setState(() {
          selections = value!;
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
              title: Text(
                'Q${widget.index}.    ${widget.questions.question}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            _getRadioTile(Selections.A, 'A  :  ${widget.questions.answerA}'),
            _getRadioTile(Selections.B, 'B  :  ${widget.questions.answerB}'),
            _getRadioTile(Selections.C, 'C  :  ${widget.questions.answerC}'),
            if(widget.questionQty >= 4) _getRadioTile(Selections.D, 'D  :  ${widget.questions.answerD}'),
            if(widget.questionQty >= 5) _getRadioTile(Selections.E, 'E  :  ${widget.questions.answerE}'),
          ],
        ),
      ),
    );
  }
}
