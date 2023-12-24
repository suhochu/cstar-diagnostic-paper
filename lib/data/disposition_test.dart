import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class DispositionTest extends QAndAData<List<Selections>> {
  DispositionTest({
    super.test = Test.dispositionTest,
    super.hasIndividualAnswers = true,
  }) {
    initiatedResultList();
  }
}
