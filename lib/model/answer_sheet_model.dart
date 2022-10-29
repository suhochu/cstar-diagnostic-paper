class AnswerSheetModel {
  String title;
  List<String?> answers;

  AnswerSheetModel({
    required this.title,
    required this.answers,
  });

  factory AnswerSheetModel.initial() {
    return AnswerSheetModel(title: '', answers: []);
  }

  AnswerSheetModel copyWith({
    List<String?>? answers,
    String? title,
  }) {
    return AnswerSheetModel(
      title: title ?? this.title,
      answers: answers ?? this.answers,
    );
  }
}

class SelfLeaderShipResultModel {
  String type;
  String explanation;

  SelfLeaderShipResultModel({
    required this.type,
    required this.explanation,
  });
}

class StressDiagnosisResultModel {
  String type;

  StressDiagnosisResultModel({
    required this.type,
  });
}

class EicDiagnosisResultModel {
  String type;

  EicDiagnosisResultModel({
    required this.type,
  });
}