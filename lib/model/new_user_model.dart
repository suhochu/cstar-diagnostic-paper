import 'package:cstarimage_testpage/data/color_disposition.dart';
import 'package:cstarimage_testpage/data/disposition_test.dart';
import 'package:cstarimage_testpage/data/eic_image.dart';
import 'package:cstarimage_testpage/data/leadership_questions.dart';
import 'package:cstarimage_testpage/data/personal_color_self.dart';
import 'package:cstarimage_testpage/data/pitr.dart';
import 'package:cstarimage_testpage/data/self_esteem_questions.dart';
import 'package:cstarimage_testpage/data/stress_response_questions.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';

class NewUserModel {
  final String name;
  final List<QAndAData> testList;

  const NewUserModel({
    required this.name,
    required this.testList,
  });

  factory NewUserModel.init() {
    return const NewUserModel(
      name: '',
      testList: [],
    );
  }

  factory NewUserModel.fromUserInput({required String code, required String name}) {
    final List<QAndAData> qList = [];
    final String subCode = code.substring(8);
    if (subCode.contains('c')) qList.add(ColorDisposition());
    if (subCode.contains('d')) qList.add(DispositionTest());
    if (subCode.contains('e')) qList.add(EicImage());
    if (subCode.contains('l')) qList.add(LeadershipQuestions());
    if (subCode.contains('n')) qList.add(PersonalColorSelfTest());
    if (subCode.contains('p')) qList.add(Pitr());
    if (subCode.contains('s')) qList.add(SelfEsteemQuestions());
    if (subCode.contains('r')) qList.add(StressResponseQuestions());
    return NewUserModel(name: name, testList: qList);
  }

  NewUserModel copyWith({
    String? name,
    List<QAndAData>? testList,
  }) {
    return NewUserModel(
      name: name ?? this.name,
      testList: testList ?? this.testList,
    );
  }
}
