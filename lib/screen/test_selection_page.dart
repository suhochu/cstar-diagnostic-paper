import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/provider/questions_provider.dart';
import 'package:cstarimage_testpage/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestSelectionPage extends ConsumerStatefulWidget {
  static String get routeName => 'TestSelectionPage';

  const TestSelectionPage({super.key});

  @override
  ConsumerState<TestSelectionPage> createState() => _TestSelectionPageState();
}

class _TestSelectionPageState extends ConsumerState<TestSelectionPage> {
  final List<String> tests = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(questionListProvider.notifier).reset();
      ref.read(answerSheetProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final classInfo = ref.read(classProvider);
    if (classInfo is ClassModel) {
      tests.clear();
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
