import 'package:cstarimage_testpage/utils/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../model/lecture_code.dart';
import '../screen/code_insert/code_insert_page.dart';
import '../screen/questions/new_question_sheet_page.dart' deferred as question;
import '../screen/result_page.dart' deferred as result;
import '../screen/selections/diaganosis_selection_page.dart' deferred as selection;

class AppRoutes {
  static String rootPage = 'rootPage';
  static String testSelectionPage = 'diagnosisSelectionPage';
  static String questionSheet = 'QuestionsSheet';
  static String resultPage = 'resultPage';
  final routes = [
    QRoute(name: rootPage, path: '/home', builder: () => CodeInsertPage()),
    QRoute(name: testSelectionPage, path: '/diagnosisSelection', builder: () => selection.DiagnosisSelectionPage(), middleware: [
      DeferredLoader(selection.loadLibrary)
    ], children: [
      QRoute(
          name: questionSheet,
          path: '/:testName',
          builder: () {
            final testName = QR.params['testName'].toString();
            return question.NewQuestionSheet(test: testName.getTestFromString() ?? Test.stressResponseQuestions);
          },
          middleware: [DeferredLoader(question.loadLibrary)]),
    ]),
    QRoute(name: resultPage, path: '/result', builder: () => result.ResultPage(), middleware: [DeferredLoader(result.loadLibrary)]),
  ];
}

class DeferredLoader extends QMiddleware {
  final Future<dynamic> Function() loader;

  @override
  Future onEnter() async {
    await loader();
    if (kDebugMode) print('users loaded');
  }

  DeferredLoader(this.loader);
}
