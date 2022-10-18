import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestSelectionPage extends ConsumerWidget {
  static String get routeName => 'TestSelectionPage';
  final List<String> tests = [];

  TestSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final classInfo = ref.read(classProvider);
    if(classInfo is ClassModel){
      tests.addAll(classInfo.accessibleTests);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView.builder(
          itemCount: tests.length,
          itemBuilder: (context, index) => CustomContainer(
            title: tests[index],
            number: index + 1,
            questionQty: tests.isEmpty ? 4 : tests.length,
          ),
        ),
      ),
    );
  }
}
