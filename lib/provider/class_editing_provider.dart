import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/classes_model.dart';
import 'package:cstarimage_testpage/repository/class_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classEditingProvider = StateNotifierProvider<ClassEditingNotifier, ClassesDataModel>((ref) {
  final repository = ref.read(classRepositoryProvider);

  return ClassEditingNotifier(repository: repository);
});

class ClassEditingNotifier extends StateNotifier<ClassesDataModel> {
  final ClassRepository repository;

  ClassEditingNotifier({required this.repository})
      : super(
          ClassesModel(
            classData: [],
          ),
        );

  Future<void> classWorkSheetInit() async {
    await repository.init();
  }

  Future<void> gelAllClasses() async {
    state = ClassesModelLoading();
    final List<Map<String, String>>? classesData = await repository.getAllDate();
    if (classesData == null) {
      return;
    }
    final classesModel = classesData.map((classData) => ClassModel.fromMap(classData)).toList();
    state = ClassesModel(classData: classesModel);
  }
}
