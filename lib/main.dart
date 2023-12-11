import 'package:cstarimage_testpage/routes/routes.dart';
import 'package:cstarimage_testpage/utils/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const _MyApp(),
    ),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

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
