import 'package:cstarimage_testpage/constants/questions.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class StressResponseQuestions extends QAndAData<List<Selections>> {
  StressResponseQuestions({
    super.test = Test.stressResponseQuestions,
    super.hasIndividualAnswers = true,
  }){
    initiatedResultList();
  }
}
