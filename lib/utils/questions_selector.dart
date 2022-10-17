import 'package:cstarimage_testpage/constants/google_sheet_info.dart';

String? testsRouteSelector(String test) {
  if (test == '스트레스 진단') {
    return GoogleSheetInfo.stressResponseQuestions;
  }

  if (test == '자존감 진단'){
    return GoogleSheetInfo.selfEsteemQuestions;
  }

  return null;
}
