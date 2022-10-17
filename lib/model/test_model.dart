import 'dart:convert';

abstract class TestDataModel {}

class TestModelError extends TestDataModel {
  String error;

  TestModelError({
    required this.error,
  });
}

class TestModelLoading extends TestDataModel {}

class TestsModel extends TestDataModel {
  List<TestModel> tests;

  TestsModel({
    required this.tests,
  });
}

class TestModel {
  int no;
  String testname;
  int answerqty;

  TestModel({
    required this.no,
    required this.testname,
    required this.answerqty,
  });

  factory TestModel.initial() {
    return TestModel(
      no: -1,
      testname: '',
      answerqty: -1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': this.no,
      'testname': this.testname,
      'answerqt': this.answerqty,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      no: jsonDecode(map['no']) as int,
      testname: map['testname'] as String,
      answerqty: jsonDecode(map['answerqt']) as int,
    );
  }

  TestModel copyWith({
    int? no,
    String? testname,
    int? answerqt,
  }) {
    return TestModel(
      no: no ?? this.no,
      testname: testname ?? this.testname,
      answerqty: answerqt ?? this.answerqty,
    );
  }

  @override
  String toString() {
    return 'TestModel{no: $no, testname: $testname, answerqty: $answerqty}';
  }

}
