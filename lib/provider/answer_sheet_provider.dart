import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/answers_model.dart';

final answerSheetProvider = StateNotifierProvider<AnswerListNotifier, AnswersModel>((ref) {
  return AnswerListNotifier(ref: ref);
});

class AnswerListNotifier extends StateNotifier<AnswersModel> {
  final Ref ref;

  AnswerListNotifier({required this.ref})
      : super(
          AnswersModel.initial(),
        );

  void addTest(Test test) {
    final int index = state.allAnswers.indexWhere((element) => element.test == test);
    if (index != -1) state.allAnswers.removeAt(index);
    final int answerLength = test.lengthOfQuestions();
    final List<Selections> selections = List.generate(answerLength, (index) => Selections.ndf);
    state.allAnswers.add(AnswerSheetModel(
      test: test,
      answers: selections,
    ));
  }

  bool containNdf(Test test) {
    if (test == Test.pitr) return false;
    final int index = state.allAnswers.indexWhere((element) => element.test == test);
    if (index != -1) {
      final List<Selections> answers = state.allAnswers[index].answers;
      return answers.contains(Selections.ndf);
    }
    return false;
  }

  List<Selections> returnSelectionsList(Test test) {
    final int index = state.allAnswers.indexWhere((element) => element.test == test);
    if (index != -1) {
      return state.allAnswers[index].answers;
    }
    return [];
  }

  void update({required Test test, required int index, required Selections selection}) {
    final int testIndex = state.allAnswers.indexWhere((element) => element.test == test);
    if (index != -1) {
      final List<Selections> answers = state.allAnswers[testIndex].answers;
      answers[index] = selection;
      AnswerSheetModel tempAnswerSheetModel = state.allAnswers[testIndex].copyWith(answers: answers);
      final List<AnswerSheetModel> tempList = state.allAnswers;
      tempList[testIndex] = tempAnswerSheetModel;
      state = state.copyWith(allAnswers: tempList);
    }
  }
}
