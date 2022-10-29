import 'dart:convert';

class QuestionModel {
  final int number;
  final String question;
  final String answerA;
  final String answerB;
  final String? answerC;
  final String? answerD;
  final String? answerE;
  final String? answerF;

  const QuestionModel({
    required this.number,
    required this.question,
    required this.answerA,
    required this.answerB,
    this.answerC,
    this.answerD,
    this.answerE,
    this.answerF,
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
      'answerF': answerF,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      number: jsonDecode(map['no']) as int,
      question: map['question'] as String,
      answerA: map['answerA'] as String,
      answerB: map['answerB'] as String,
      answerC: (map['answerC'] ?? '') as String,
      answerD: (map['answerD'] ?? '') as String,
      answerE: (map['answerE'] ?? '') as String,
      answerF: (map['answerF'] ?? '') as String,
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
    String? answerF,
  }) {
    return QuestionModel(
      number: number ?? this.number,
      question: question ?? this.question,
      answerA: answerA ?? this.answerA,
      answerB: answerB ?? this.answerB,
      answerC: answerC ?? this.answerC,
      answerD: answerD ?? this.answerD,
      answerE: answerE ?? this.answerE,
      answerF: answerF ?? this.answerF,
    );
  }

  @override
  String toString() {
    return 'QuestionModel{number: $number, question: $question, answerA: $answerA, answerB: $answerB, answerC: $answerC, answerD: $answerD, answerE: $answerE, answerF: $answerF}';
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
