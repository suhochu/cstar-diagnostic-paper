class AnswerSheetModel {
  List<String> answerSheet;
  List<String> result;
  String userName;
  String userEmail;
  String testDate;
  String company;
  String classPlace;

  AnswerSheetModel({
    required this.answerSheet,
    required this.result,
    required this.userName,
    required this.userEmail,
    required this.testDate,
    required this.company,
    required this.classPlace,
  });

  factory AnswerSheetModel.initial() {
    return AnswerSheetModel(
      answerSheet: [],
      result: [],
      company: '',
      testDate: '',
      classPlace: '',
      userEmail: '',
      userName: '',
    );
  }

  AnswerSheetModel copyWith({
    List<String>? answerSheet,
    List<String>? result,
    String? userName,
    String? userEmail,
    String? testDate,
    String? company,
    String? classPlace,
  }) {
    return AnswerSheetModel(
      answerSheet: answerSheet ?? this.answerSheet,
      result: result ?? this.result,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      testDate: testDate ?? this.testDate,
      company: company ?? this.company,
      classPlace: classPlace ?? this.classPlace,
    );
  }
}
