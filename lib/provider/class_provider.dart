import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/classes_model.dart';
import 'package:cstarimage_testpage/provider/class_editing_provider.dart';
import 'package:cstarimage_testpage/repository/class_repository.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classProvider = StateNotifierProvider<ClassNotifier, ClassesDataModel>((ref) {
  final repository = ref.read(classRepositoryProvider);

  return ClassNotifier(repository: repository, ref: ref);
});

class ClassNotifier extends StateNotifier<ClassesDataModel> {
  final ClassRepository repository;
  final StateNotifierProviderRef ref;

  ClassNotifier({required this.repository, required this.ref}) : super(ClassesModelLoading());

  Future<void> classWorkSheetInit() async {
    await repository.init();
  }

  Future<void> getTodayClassData(DateTime dateTime) async {
    final String today = getYearMonthDate(dateTime);
    state = ClassesModelLoading();
    final List<Map<String, String>>? classesData = await repository.getAllDate();
    if (classesData == null) {
      state = ClassesModelError(error: '서버에 문제가 있습니다. 나중에 재시도 부탁드립니다.');
      return;
    }
    final classesModel = classesData.map((classData) => ClassModel.fromMap(classData)).toList();
    final todayClasses = classesModel.where((classData) => classData.testDate == today).toList();
    if (todayClasses.isEmpty) {
      state = ClassesModelError(error: '오늘 날짜의 강의가 없습니다.');
      return;
    }
    state = ClassesModel(classData: todayClasses);
  }

  void errorOnSave() {
    state = ClassesModelError(error: '저장중에 문제가 발생했습니다. 재실행 부탁드립니다.');
  }

  Future<bool> addRow(ClassModel classModel) async {
    final Map<String, String> map = classModel.toMap();
    final result = await repository.insertRow(row: map);
    if (result) ref.read(classEditingProvider.notifier).gelAllClasses();
    return result;
  }

  Future<bool> insertClassByDate(ClassModel classModel) async {
    final Map<String, String> map = classModel.toMap();
    final result = await repository.insertRowByDate(classModel.no, map);
    if (result) ref.read(classEditingProvider.notifier).gelAllClasses();
    return result;
  }

  Future<int> getLastClassIndex() async {
    final classData = await repository.getLastData();
    if (classData != null) {
      final classModel = ClassModel.fromMap(classData);
      return classModel.no;
    }
    return -1;
  }

  Future<bool> checkLectureCodeDuplicated(ClassModel classModel) async {
    final List<Map<String, String>>? classesData = await repository.getAllDate();
    if (classesData == null) {
      return true;
    }
    final classesModel = classesData.map((classData) => ClassModel.fromMap(classData)).toList();
    final todayClasses = classesModel
        .where((classData) => (classData.testDate == classModel.testDate) && (classData.lectureCode == classModel.lectureCode))
        .toList();
    if (todayClasses.isEmpty) {
      return false;
    }
    return true;
  }
}
