import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/lecture_code.dart';

class AnswerSheetModel {
  Test? test;
  List<Selections> answers;

  AnswerSheetModel({
    required this.test,
    required this.answers,
  });

  factory AnswerSheetModel.initial() {
    return AnswerSheetModel(test: null, answers: []);
  }

  AnswerSheetModel copyWith({
    List<Selections>? answers,
    Test? test,
  }) {
    return AnswerSheetModel(
      test: test ?? this.test,
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

class DispositionResultModel {
  List<String> type1;
  List<String> type2;

  DispositionResultModel({
    required this.type1,
    required this.type2,
  });

  DispositionResultModel copyWith({
    List<String>? type1,
    List<String>? type2,
  }) {
    return DispositionResultModel(
      type1: type1 ?? this.type1,
      type2: type2 ?? this.type2,
    );
  }

  @override
  String toString() {
    return 'DispositionResultModel{type1: $type1, type2: $type2}';
  }
}
