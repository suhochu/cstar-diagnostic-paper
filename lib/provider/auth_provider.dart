import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/question_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/provider/questions_provider.dart';
import 'package:cstarimage_testpage/screen/class_page.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/screen/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ),
        GoRoute(
          path: '/${UserPage.routeName}',
          name: UserPage.routeName,
          builder: (_, __) => const UserPage(),
        ),
        GoRoute(
          path: '/${TestSelectionPage.routeName}',
          name: TestSelectionPage.routeName,
          builder: (_, __) => TestSelectionPage(),
          routes: [
            GoRoute(
              path: '${QuestionsSheetPage.routeName}/:rid',
              name: QuestionsSheetPage.routeName,
              builder: (_, state) => QuestionsSheetPage(
                title: state.params['rid']!,
                // questionQty: int.tryParse(state.queryParams['questionQty']!)!
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/${ResultPage.routeName}',
          name: ResultPage.routeName,
          builder: (_, state) => ResultPage(
            // totalQuestionQty: int.tryParse(
            //   state.queryParams['totalQty']!,
            // )!,
          ),
        ),
      ];

  Future<String?> redirectLogic(BuildContext context, GoRouterState state) async {
    // final ClassDataModel? classModel = ref.read(classProvider);
    final classPage = state.location == '/';
    final userPage = state.location == '/${UserPage.routeName}';
    final testSelectionPage = state.location == '/${TestSelectionPage.routeName}';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print('============================');
    print('classes are');
    print(prefs.getStringList('class').toString());
    print('============================');
    print('users are');
    print(prefs.getStringList('user').toString());
    print('============================');

    if (!classPage) {
      if (prefs.getStringList('class') == null) {
        print('not authorized');
        return '/';
      }
    }

    if (!(classPage || userPage)) {
      if (prefs.getStringList('user') == null) {
        print('not authorized && not have user');
        return '/${UserPage.routeName}';
      }
    }

    // final QuestionDataModel questionsModel = ref.read(questionListProvider);
    //
    // bool defaultsRoutes = classPage || userPage || testSelectionPage;
    //
    // if (questionsModel is QuestionModelsLoading) {
    //   print('enter here');
    //   print(defaultsRoutes);
    //   return defaultsRoutes ? null : '/${TestSelectionPage.routeName}';
    // }

    // if (!classPage) {
    //   print('class information is ${prefs.getStringList('class')}');
    //   if (prefs.getStringList('class') == null) {
    //     return '/';
    //   }
    // }
    //
    // if (!(classPage || userPage || testSelectionPage)) {
    //   print('user information is ${prefs.getStringList('user')}');
    //   if (prefs.getStringList('user') != null) {
    //     print('enter here');
    //     return '/${TestSelectionPage.routeName}';
    //   }
    // }

    // if (classModel is ClassModelLoading) {
    //
    //   return classPage ? null : '/';
    // }
    return null;
  }
}
