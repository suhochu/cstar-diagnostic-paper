import 'package:cstarimage_testpage/utils/strings.dart';

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
  String classRoom;
  String place;

  ClassModel({
    required this.lectureCode,
    required this.testDate,
    required this.accessibleTests,
    required this.classRoom,
    required this.place,
  });

  factory ClassModel.initial() {
    return ClassModel(
      lectureCode: '',
      testDate: '',
      accessibleTests: [],
      classRoom: '',
      place: '',
    );
  }

  Map<String, dynamic> toMap() {
    print(testDate.toString().split(' ')[0]);
    return {
      'lectureCode': lectureCode,
      'testdate': "'${testDate.toString().split(' ')[0]}",
      'accessibleTests': accessibleTests.toString(),
      'classroom': classRoom,
      'place': place,
    };
  }

  factory ClassModel.fromMap(Map<String, String> map) {
    return ClassModel(
      lectureCode: map['lectureCode'] as String,
      testDate: map['testdate'] as String,
      accessibleTests: stringToList(map['accessibleTests']! ?? ''),
      classRoom: map['classroom'] as String,
      place: map['place'] as String,
    );
  }

  ClassModel copyWith({
    String? lectureCode,
    String? testDate,
    List<String>? accessibleTests,
    String? classRoom,
    String? place,
  }) {
    return ClassModel(
      lectureCode: lectureCode ?? this.lectureCode,
      testDate: testDate ?? this.testDate,
      accessibleTests: accessibleTests ?? this.accessibleTests,
      classRoom: classRoom ?? this.classRoom,
      place: place ?? this.place,
    );
  }

  factory ClassModel.fromList(List<String?> list) {
    return ClassModel(
      lectureCode: '',
      testDate: list[1] as String,
      accessibleTests: stringToList(list[2]! ?? ''),
      classRoom: list[3] as String,
      place: list[4] as String,
    );
  }

  List<String> propertiesToList() {
    return ['', testDate, accessibleTests.toString(), classRoom, place];
  }

  @override
  String toString() {
    return 'ClassModel{lectureCode: $lectureCode, testDate: $testDate, accessibleTests: $accessibleTests, company: $classRoom, place: $place}';
  }
}
