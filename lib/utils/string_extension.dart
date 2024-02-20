import 'package:cstarimage_testpage/model/lecture_code.dart';

import '../constants/data_contants.dart';

extension GetSelections on String {
  Selections getSelectionFromString() {
    switch (this) {
      case 'A':
        return Selections.A;
      case 'B':
        return Selections.B;
      case 'C':
        return Selections.C;
      case 'D':
        return Selections.D;
      case 'E':
        return Selections.E;
      default:
        return Selections.ndf;
    }
  }

  Test? getTestFromString() {
    switch (this) {
      case 'Test.pitr':
        return Test.pitr;
      case 'Test.colorDisposition':
        return Test.colorDisposition;
      case 'Test.dispositionTest':
        return Test.dispositionTest;
      case 'Test.eicImage':
        return Test.eicImage;
      case 'Test.leadershipQuestions':
        return Test.leadershipQuestions;
      case 'Test.personalColorSelfTest':
        return Test.personalColorSelfTest;
      case 'Test.selfEsteemQuestions':
        return Test.selfEsteemQuestions;
      case 'Test.stressResponseQuestions':
        return Test.stressResponseQuestions;
    }
    return null;
  }
}
