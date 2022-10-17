import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/repository/questions_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionListProvider = StateNotifierProvider<QuestionListNotifier, QuestionDataModel>((ref) {
  final repository = ref.read(questionsRepositoryProvider);
  return QuestionListNotifier(repository: repository);
});

class QuestionListNotifier extends StateNotifier<QuestionDataModel> {
  final QuestionsRepository repository;

  QuestionListNotifier({required this.repository})
      : super(
          QuestionModelsLoading(),
        );

  Future<void> selectQuestionSheet(String testSheet) async {
    await repository.getQuestionsSheet(testSheet);
  }

  Future<void> getAllQuestions() async {
    state = QuestionModelsLoading();
    final List<Map<String, dynamic>>? questions = await repository.getAllRows();
    if (questions == null) {
      state = QuestionModelsError(error: '질문지를 불러 올수 없습니다. 다시 시작 부탁드립니다.');
    } else {
      final List<QuestionModel> questionsList = questions.map((question) {
        return QuestionModel.fromMap(question);
      }).toList();
      state = QuestionsModel(questions: questionsList);
    }
  }
}
