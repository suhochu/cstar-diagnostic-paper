import 'dart:convert';

class QuestionModel {
  final int number;
  final String question;
  final String answerA;
  final String answerB;
  final String answerC;
  final String? answerD;
  final String? answerE;

  const QuestionModel({
    required this.number,
    required this.question,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    this.answerD,
    this.answerE,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'question': question,
      'answerA': answerA,
      'answerB': answerB,
      'answerC': answerC,
      'answerD': answerD,
      'answerE': answerE,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      number: jsonDecode(map['no']) as int,
      question: map['question'] as String,
      answerA: map['answerA'] as String,
      answerB: map['answerB'] as String,
      answerC: map['answerC'] as String,
      answerD: (map['answerD'] ?? '') as String,
      answerE: (map['answerE'] ?? '') as String,
    );
  }

  QuestionModel copyWith({
    int? number,
    String? question,
    String? answerA,
    String? answerB,
    String? answerC,
    String? answerD,
    String? answerE,
  }) {
    return QuestionModel(
      number: number ?? this.number,
      question: question ?? this.question,
      answerA: answerA ?? this.answerA,
      answerB: answerB ?? this.answerB,
      answerC: answerC ?? this.answerC,
      answerD: answerD ?? this.answerD,
      answerE: answerE ?? this.answerE,
    );
  }

  @override
  String toString() {
    return 'QuestionModel{number: $number, question: $question, answerA: $answerA, answerB: $answerB, answerC: $answerC, answerD: $answerD, answerE: $answerE}';
  }
}

abstract class QuestionDataModel {}

class QuestionModelsLoading extends QuestionDataModel {}

class QuestionModelsError extends QuestionDataModel {
  String error;

  QuestionModelsError({
    required this.error,
  });
}

class QuestionsModel extends QuestionDataModel {
  final List<QuestionModel> questions;

  QuestionsModel({
    required this.questions,
  });

  factory QuestionsModel.initial() {
    return QuestionsModel(questions: []);
  }
}
