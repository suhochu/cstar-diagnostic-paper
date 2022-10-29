import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/screen/class_page.dart';
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
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/${ResultPage.routeName}',
          name: ResultPage.routeName,
          builder: (_, state) => ResultPage(),
        ),
      ];

  Future<String?> redirectLogic(BuildContext context, GoRouterState state) async {
    final classPage = state.location == '/';
    final userPage = state.location == '/${UserPage.routeName}';
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

    if (classPage) {
      if (prefs.getStringList('class') != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              '이미 오늘의 코드를 인증 하셨습니다.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        );
        return '/${UserPage.routeName}';
      }
    }
  }
}
