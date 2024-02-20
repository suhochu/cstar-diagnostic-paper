import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../model/lecture_code.dart';

class StressResponseQuestions extends QAndAData {
  StressResponseQuestions({
    super.test = Test.stressResponseQuestions,
    super.hasIndividualAnswers = true,
  }) {
    initiatedResultList();
  }
}
