import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:go_router/go_router.dart';

import '../model/lecture_code.dart';
import '../model/questions_answers_data.dart';
import '../screen/code_insert/code_insert_page.dart';
import '../screen/questions/new_question_sheet_page.dart';
import '../screen/selections/diaganosis_selection_page.dart';

class RouteConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: '/',
        builder: (_, __) => CodeInsertPage(),
      ),
      GoRoute(
        path: '/${DiagnosisSelectionPage.routeName}',
        name: DiagnosisSelectionPage.routeName,
        builder: (_, __) => const DiagnosisSelectionPage(),
        routes: [
          GoRoute(
            path: NewQuestionSheet.routeName,
            name: NewQuestionSheet.routeName,
            builder: (_, GoRouterState state) => NewQuestionSheet(
              // qAndAData: state.extra as QAndAData?,
              test: state.extra as Test?,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/${ResultPage.routeName}',
        name: ResultPage.routeName,
        builder: (_, state) => ResultPage(),
      ),
    ],
  );
}
