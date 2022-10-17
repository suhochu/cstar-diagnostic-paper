import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final answerSheetProvider = StateNotifierProvider<AnswerListNotifier, AnswerSheetModel>((ref) {
  return AnswerListNotifier(ref: ref);
});

class AnswerListNotifier extends StateNotifier<AnswerSheetModel> {
  final Ref ref;
  UserModel user = UserModel.initial();
  ClassModel classInfo = ClassModel.initial();

  AnswerListNotifier({required this.ref})
      : super(
          AnswerSheetModel.initial(),
        );

  void initialize(int questionQty) {
    final userModel = ref.read(userProvider);
    final classModel = ref.read(classProvider);

    if (userModel is UserModel) {
      user = userModel;
    }

    if (classModel is ClassModel) {
      classInfo = classModel;
    }

    state = state.copyWith(
      userEmail: user.email,
      classPlace: classInfo.place,
      company: user.company,
      testDate: classInfo.testDate,
      userName: user.name,
      result: [],
      answerSheet: initialAnswerSheet(questionQty)
    );
    print(state.toString());
  }


  void update(int index, Selections selection) {
    String answer = 'A';
    List<String> answerMap = state.answerSheet;

    switch (selection) {
      case Selections.A:
        answer = 'A';
        break;
      case Selections.B:
        answer = 'B';
        break;
      case Selections.C:
        answer = 'C';
        break;
      case Selections.D:
        answer = 'D';
        break;
      case Selections.E:
        answer = 'E';
        break;
    }
    answerMap[index] = answer;
    state = state.copyWith(answerSheet: answerMap);
  }
}
