import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../model/lecture_code.dart';

class PersonalColorSelfTest extends QAndAData {
  PersonalColorSelfTest({
    super.test = Test.personalColorSelfTest,
    super.hasIndividualAnswers = true,
  }) {
    initiatedResultList();
  }
}
