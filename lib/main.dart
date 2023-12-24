import 'package:cstarimage_testpage/routes/routes.dart';
import 'package:cstarimage_testpage/screen/result_page.dart' deferred as result;
import 'package:cstarimage_testpage/screen/selections/diaganosis_selection_page.dart' deferred as selection;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/lecture_code.dart';
import 'screen/code_insert/code_insert_page.dart';
import 'screen/questions/new_question_sheet_page.dart' deferred as questions;

void main() {
  runApp(
    const ProviderScope(
      child: _MyApp(),
    ),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cstar Image',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Pretendard'
      ),
      routerConfig: RouteConfig.goRouter,
    );
  }
}
