import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/repository/class_repository.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classProvider = StateNotifierProvider<ClassNotifier, ClassDataModel>((ref) {
  final repository = ref.read(classRepositoryProvider);

  return ClassNotifier(repository: repository);
});

class ClassNotifier extends StateNotifier<ClassDataModel> {
  final ClassRepository repository;

  ClassNotifier({required this.repository})
      : super(
          ClassModelLoading(),
        );

  Future<void> classWorkSheetInit() async {
    await repository.init();
  }

  Future<void> getTodayClassData(DateTime dateTime) async {
    final String date = getYearMonthDate(dateTime);
    state = ClassModelLoading();
    final classData = await repository.getRowByDate(date);
    if (classData == null) {
      state = ClassModelError(error: '오늘 날짜의 강의가 없습니다.');
      return;
    }
    ClassModel classModel = ClassModel.fromMap(classData);
    state = classModel;
  }

  void getTodayClassFromDevice(List<String> classInfo) {
    state = ClassModelLoading();
    ClassModel classModel = ClassModel.fromList(classInfo);
    state = classModel;
  }

  void errorOnSave() {
    state = ClassModelError(error: '저장중에 문제가 발생했습니다. 재실행 부탁드립니다.');
  }
}
