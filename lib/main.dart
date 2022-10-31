import 'package:cstarimage_testpage/routes/routes.dart';
import 'package:cstarimage_testpage/utils/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      child: const _MyApp(),
    ),
  );
}

class _MyApp extends ConsumerWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cstar Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
