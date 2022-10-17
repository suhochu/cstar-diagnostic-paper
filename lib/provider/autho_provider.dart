import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/screen/class_page.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/screen/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref: ref));

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<ClassDataModel>(classProvider, (previous, next) {
      if (previous != null) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: '/',
          builder: (_, __) => const ClassPage(),
          routes: [
            GoRoute(
              path: UserPage.routeName,
              name: UserPage.routeName,
              builder: (_, __) => const UserPage(),
              routes: [
                GoRoute(
                  path: TestSelectionPage.routeName,
                  name: TestSelectionPage.routeName,
                  builder: (_, __) => const TestSelectionPage(),
                  routes: [
                    GoRoute(
                      path: '${QuestionsSheetPage.routeName}/:rid',
                      name: QuestionsSheetPage.routeName,
                      builder: (_, state) => QuestionsSheetPage(
                          title: state.params['rid']!, questionQty: int.tryParse(state.queryParams['questionQty']!)!),
                    ),
                  ],
                ),
                GoRoute(
                  path: ResultPage.routeName,
                  name: ResultPage.routeName,
                  builder: (_, state) => ResultPage(totalQuestionQty: int.tryParse(state.queryParams['totalQty']!)!),
                ),
              ],
            ),
          ],
        ),
      ];

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final ClassDataModel? classModel = ref.read(classProvider);
    final authorizedPage = state.location == '/';

    if (classModel is ClassModelLoading) {
      return authorizedPage ? null : '/';
    }
  }
}
