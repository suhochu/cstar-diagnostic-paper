import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class SelfEsteemQuestions extends QAndAData<List<Selections>> {
  SelfEsteemQuestions({
    super.test = Test.selfEsteemQuestions,
  }) {
    initiatedResultList();
  }
}
