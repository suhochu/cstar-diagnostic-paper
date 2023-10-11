import 'package:cstarimage_testpage/model/class_model.dart';

abstract class ClassesDataModel {}

class ClassesModelError extends ClassesDataModel {
  String error;

  ClassesModelError({
    required this.error,
  });
}

class ClassesModelLoading extends ClassesDataModel {}

class ClassesModel extends ClassesDataModel {
  final List<ClassModel> classData;

  ClassesModel({
    required this.classData,
  });

  factory ClassesModel.initial() {
    return ClassesModel(classData: []);
  }
}
