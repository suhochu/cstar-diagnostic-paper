import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final answerSheetProvider = StateNotifierProvider<AnswerListNotifier, AnswerSheetModel>((ref) {
  return AnswerListNotifier(ref: ref);
});

class AnswerListNotifier extends StateNotifier<AnswerSheetModel> {
  final Ref ref;

  AnswerListNotifier({required this.ref})
      : super(
          AnswerSheetModel.initial(),
        );

  void initialize(int questionQty) {
    state = state.copyWith(answers: initialAnswerSheet(questionQty));
  }

  void reset() {
    state = AnswerSheetModel.initial();
  }

  void update(int index, Selections selection) {
    String answer = 'A';
    List<String?> answerMap = state.answers;


    switch (selection) {
      case Selections.A:
        answer = 'A';
        break;
      case Selections.B:
        answer = 'B';
        break;
      case Selections.C:
        answer = 'C';
        break;
      case Selections.D:
        answer = 'D';
        break;
      case Selections.E:
        answer = 'E';
        break;
      case Selections.F:
        answer = 'F';
    }
    answerMap[index] = answer;
    state = state.copyWith(answers: answerMap);
    print('state.answers is${state.answers}');
  }
}
