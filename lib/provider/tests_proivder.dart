import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/test_model.dart';
import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/provider/user_provider.dart';
import 'package:cstarimage_testpage/repository/tests_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final testProvider = StateNotifierProvider<TestNotifier, TestDataModel>((ref) {
  final repository = ref.watch(testRepositoryProvider);
  return TestNotifier(
    repository: repository,
  );
});

class TestNotifier extends StateNotifier<TestDataModel> {
  final TestRepository repository;

  TestNotifier({
    required this.repository,
  }) : super(
          TestModelLoading(),
        );

  Future<void> testWorkSheetInit() async {
    await repository.init();
  }

  Future<void> getAllTests() async {
    state = TestModelLoading();
    final List<Map<String, String>>? testsMapData = await repository.getAllRows();
    if (testsMapData == null) {
      state = TestModelError(error: '진단 데이터를 불러오지 못했습니다.');
    }
    final List<TestModel> tests = testsMapData!.map((test) => TestModel.fromMap(test)).toList();
    state = TestsModel(tests: tests);
    print(tests);
  }
}
