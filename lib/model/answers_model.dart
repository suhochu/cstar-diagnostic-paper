import 'answer_sheet_model.dart';

class AnswersModel {
  List<AnswerSheetModel> allAnswers;

  AnswersModel({
    required this.allAnswers,
  });

  factory AnswersModel.initial() {
    return AnswersModel(allAnswers: []);
  }

  AnswersModel copyWith({
    List<AnswerSheetModel>? allAnswers,
  }) {
    return AnswersModel(
      allAnswers: allAnswers ?? this.allAnswers,
    );
  }
}
