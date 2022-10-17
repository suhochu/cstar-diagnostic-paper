import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/test_model.dart';
import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/provider/tests_proivder.dart';
import 'package:cstarimage_testpage/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestSelectionPage extends ConsumerStatefulWidget {
  static String get routeName => 'TestSelectionPage';

  const TestSelectionPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TestSelectionPage> createState() => _TestSelectionPageState();
}

class _TestSelectionPageState extends ConsumerState<TestSelectionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    await ref.read(testProvider.notifier).testWorkSheetInit();
    await ref.read(testProvider.notifier).getAllTests();
  }

  @override
  Widget build(BuildContext context) {
    final TestDataModel testsData = ref.watch(testProvider);

    if (testsData is TestModelLoading) {
      return const Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        ),
      );
    }
    if (testsData is TestModelError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            testsData.error,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    testsData as TestsModel;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30),
      child: ListView.builder(
        itemCount: testsData.tests.length,
        itemBuilder: (context, index) => CustomContainer(
          title: testsData.tests[index].testname,
          number: index + 1,
          questionQty: testsData.tests[index].answerqty,
        ),
      ),
    ));
  }
}
