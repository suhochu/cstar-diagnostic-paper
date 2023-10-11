import 'dart:convert';

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
  int no;
  String lectureCode;
  String testDate;
  List<String> accessibleTests;
  String classRoom;
  String place;

  ClassModel({
    required this.no,
    required this.lectureCode,
    required this.testDate,
    required this.accessibleTests,
    required this.classRoom,
    required this.place,
  });

  factory ClassModel.initial() {
    return ClassModel(
      no: -1,
      lectureCode: '',
      testDate: '',
      accessibleTests: [],
      classRoom: '',
      place: '',
    );
  }

  Map<String, String> toMap() {
    final stringAccessibleTests = accessibleTests.toString();
    final tailoredAccessibleTests = stringAccessibleTests.substring(1, stringAccessibleTests.length - 1);
    return {
      'lectureCode': lectureCode,
      'testdate': "'${testDate.toString().split(' ')[0]}",
      'accessibleTests': tailoredAccessibleTests,
      'classroom': classRoom,
      'place': place,
      'no': no.toString(),
    };
  }

  factory ClassModel.fromMap(Map<String, String> map) {
    return ClassModel(
      lectureCode: map['lectureCode'] as String,
      testDate: map['testdate'] as String,
      accessibleTests: stringToList(map['accessibleTests']! ?? ''),
      classRoom: map['classroom'] as String,
      place: map['place'] as String,
      no: jsonDecode(map['no']!),
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
      no: no,
      lectureCode: lectureCode ?? this.lectureCode,
      testDate: testDate ?? this.testDate,
      accessibleTests: accessibleTests ?? this.accessibleTests,
      classRoom: classRoom ?? this.classRoom,
      place: place ?? this.place,
    );
  }

//todo List Number 수정
  factory ClassModel.fromList(List<String?> list) {
    return ClassModel(
        lectureCode: '',
        testDate: list[1] as String,
        accessibleTests: stringToList(list[2]! ?? '', subtract: true),
        classRoom: list[3] as String,
        place: list[4] as String,
        no: -1);
  }

  List<String> propertiesToList() {
    return ['', testDate, accessibleTests.toString(), classRoom, place];
  }

  @override
  String toString() {
    return 'ClassModel{lectureCode: $lectureCode, testDate: $testDate, accessibleTests: $accessibleTests, company: $classRoom, place: $place}';
  }
}
