import 'package:cstarimage_testpage/constants/google_sheet_info.dart';

class TestQuestionPageSelectorUtil {
  String? testsRouteSelector(String test) {
    if (test == '스트레스 진단') {
      return GoogleSheetInfo.stressResponseQuestions;
    }

    if (test == '자존감 진단') {
      return GoogleSheetInfo.selfEsteemQuestions;
    }

    if (test == '리더십 유형') {
      return GoogleSheetInfo.leadershipQuestions;
    }

    if (test == 'EIC 이미지 셀프 진단'){
      return GoogleSheetInfo.eicImageQuestions;
    }

    if (test == 'Color Disposition Checklist'){
      return GoogleSheetInfo.colorDispositionChecklist;
    }

    return null;
  }
}
