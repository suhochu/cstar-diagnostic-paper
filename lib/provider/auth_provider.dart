import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/classes_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/screen/class_page.dart';
import 'package:cstarimage_testpage/screen/instructors_page/instructors_data_input_page.dart';
import 'package:cstarimage_testpage/screen/instructors_page/instructors_data_read_page.dart';
import 'package:cstarimage_testpage/screen/question_sheet_page.dart';
import 'package:cstarimage_testpage/screen/result_page.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/screen/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref: ref));

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<ClassesDataModel>(classProvider, (previous, next) {
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
              builder: (_, GoRouterState state) => QuestionsSheetPage(
                title: state.pathParameters['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/${ResultPage.routeName}',
          name: ResultPage.routeName,
          builder: (_, state) => ResultPage(),
        ),
        GoRoute(
            path: '/${InstructorsDataReadPage.routeName}',
            name: InstructorsDataReadPage.routeName,
            builder: (_, __) => const InstructorsDataReadPage(),
            routes: [
              GoRoute(
                path: InstructorsDataInputPage.routeName,
                name: InstructorsDataInputPage.routeName,
                builder: (_, state) => InstructorsDataInputPage(classModel: state.extra as ClassModel?),
              ),
            ]),
      ];

  Future<String?> redirectLogic(BuildContext context, GoRouterState state) async {
    final classPage = state.fullPath == '/';
    final userPage = state.fullPath == '/${UserPage.routeName}';
    final instructorsReadPage = state.fullPath == '/${InstructorsDataReadPage.routeName}';
    final instructorsInputPage = state.fullPath == '/${InstructorsDataReadPage.routeName}/${InstructorsDataInputPage.routeName}';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print('============================');
    print('classes are');
    print(prefs.getStringList('class').toString());
    print('============================');
    print('users are');
    print(prefs.getStringList('user').toString());
    print('============================');

    if (!classPage && !instructorsReadPage && !instructorsInputPage) {
      if (prefs.getStringList('class') == null) {
        print('not authorized');
        return '/';
      }
    }

    if (!(classPage || userPage) && !instructorsReadPage && !instructorsInputPage) {
      if (prefs.getStringList('user') == null) {
        print('not authorized && not have user');
        return '/${UserPage.routeName}';
      }
    }

    return null;
  }
}
