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

  int lengthOfQuestions() {
    return switch (this) {
      Test.colorDisposition => 80,
      Test.dispositionTest => 29,
      Test.eicImage => 51,
      Test.leadershipQuestions => 25,
      Test.personalColorSelfTest => 9,
      Test.pitr => 45,
      Test.selfEsteemQuestions => 20,
      Test.stressResponseQuestions => 18,
    };
  }
}

class LectureCode {
  static String getLectureCode() {
    // final today = DateTime.now();
    // final int year = today.year;
    // final int monthDay = today.month * 100 + today.day;
    return '20230725';
  }
}
