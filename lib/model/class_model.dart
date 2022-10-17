abstract class ClassDataModel {}

class ClassModelError extends ClassDataModel {
  String error;

  ClassModelError({
    required this.error,
  });
}

class ClassModelLoading extends ClassDataModel {}

class ClassModel extends ClassDataModel {
  String lectureCode;
  String testDate;
  List<String> accessibleTests;
  String company;
  String place;

  ClassModel({
    required this.lectureCode,
    required this.testDate,
    required this.accessibleTests,
    required this.company,
    required this.place,
  });

  factory ClassModel.initial() {
    return ClassModel(
      lectureCode: '',
      testDate: '',
      accessibleTests: [],
      company: '',
      place: '',
    );
  }

  Map<String, dynamic> toMap() {
    print(testDate.toString().split(' ')[0]);
    return {
      'lectureCode': lectureCode,
      'testdate': "'${testDate.toString().split(' ')[0]}",
      'accessibleTests': accessibleTests.toString(),
      'company': company,
      'place': place,
    };
  }

  factory ClassModel.fromMap(Map<String, String> map) {
    return ClassModel(
      lectureCode: map['lectureCode'] as String,
      testDate: map['testdate'] as String,
      accessibleTests: [],
      company: map['company'] as String,
      place: map['place'] as String,
    );
  }

  ClassModel copyWith({
    String? lectureCode,
    String? testDate,
    List<String>? accessibleTests,
    String? company,
    String? place,
  }) {
    return ClassModel(
      lectureCode: lectureCode ?? this.lectureCode,
      testDate: testDate ?? this.testDate,
      accessibleTests: accessibleTests ?? this.accessibleTests,
      company: company ?? this.company,
      place: place ?? this.place,
    );
  }

  @override
  String toString() {
    return 'ClassModel{lectureCode: $lectureCode, testDate: $testDate, accessibleTests: $accessibleTests, company: $company, place: $place}';
  }
}
