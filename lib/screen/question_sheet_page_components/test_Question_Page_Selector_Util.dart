import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/constants/google_sheet_info.dart';



class TestQuestionPageSelectorUtil {
  String? testsRouteSelector(String test) {
    if (test == testsName[0]) {
      return GoogleSheetInfo.stressResponseQuestions;
    }

    if (test == testsName[1]) {
      return GoogleSheetInfo.selfEsteemQuestions;
    }

    if (test == testsName[2]) {
      return GoogleSheetInfo.leadershipQuestions;
    }

    if (test == testsName[3]) {
      return GoogleSheetInfo.eicImageQuestions;
    }

    if (test == testsName[4]) {
      return GoogleSheetInfo.colorDispositionChecklist;
    }

    if (test == testsName[5]) {
      return GoogleSheetInfo.pitr;
    }

    if (test == testsName[6]) {
      return GoogleSheetInfo.dispositionTest1;
    }

    return null;
  }
}
