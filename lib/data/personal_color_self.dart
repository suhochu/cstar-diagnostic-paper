import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class PersonalColorSelfTest extends QAndAData<List<Selections>> {
  PersonalColorSelfTest({
    super.test = Test.personalColorSelfTest,
    super.hasIndividualAnswers = true,
  }) {
    initiatedResultList();
  }
}
