import 'package:cstarimage_testpage/data/personal_color_self.dart';
import 'package:cstarimage_testpage/data/pitr.dart';
import 'package:cstarimage_testpage/data/self_esteem_questions.dart';
import 'package:cstarimage_testpage/data/stress_response_questions.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../data/color_disposition.dart';
import '../data/disposition_test.dart';
import '../data/eic_image.dart';
import '../data/leadership_questions.dart';

enum Test {
  colorDisposition('c', 'Color Disposition Checklist'),
  dispositionTest('d', ' Disposition Test'),
  eicImage('e', 'EIC 이미지 셀프 진단'),
  leadershipQuestions('l', '리더십 유형'),
  personalColorSelfTest('n', '퍼스널 컬러 셀프 진단'),
  pitr('p', 'PITR'),
  selfEsteemQuestions('s', '자존감 진단'),
  stressResponseQuestions('r', '스트레스 진단');

  const Test(this.seedCode, this.name);

  final String seedCode;
  final String name;

  QAndAData selectQAndData() {
    switch (this) {
      case Test.colorDisposition:
        return ColorDisposition();
      case Test.dispositionTest:
        return DispositionTest();
      case Test.eicImage:
        return EicImage();
      case Test.leadershipQuestions:
        return LeadershipQuestions();
      case Test.personalColorSelfTest:
        return PersonalColorSelfTest();
      case Test.pitr:
        return Pitr();
      case Test.selfEsteemQuestions:
        return SelfEsteemQuestions();
      case Test.stressResponseQuestions:
        return StressResponseQuestions();
    }
  }
}

class LectureCode {
  static String getLectureCode() {
    final today = DateTime.now();
    final int year = today.year;
    final int monthDay = today.month * 100 + today.day;
    return '20230725';
  }
}
