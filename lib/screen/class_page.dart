import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/provider/user_provider.dart';
import 'package:cstarimage_testpage/screen/user_page.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/buttons.dart';

class ClassPage extends ConsumerStatefulWidget {
  static String get routeName => 'EnterPage';

  const ClassPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ClassPage> createState() => _EnterPageState();
}

class _EnterPageState extends ConsumerState<ClassPage> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> init() async {
    ref.read(userProvider.notifier).userUnAuthorize();
    await ref.read(classProvider.notifier).classWorkSheetInit();
    await ref.read(classProvider.notifier).getTodayClassData(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final ClassDataModel classData = ref.watch(classProvider);

    if (classData is ClassModelLoading) {
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
    if (classData is ClassModelError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            classData.error,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            const SizedBox(height: 24),
            CustomSizedBox(
              child: Form(
                key: _formKey,
                child: CustomTextField(
                  hint: '오늘의 교육 코드를 입력하세요',
                  label: '교육 코드',
                  controller: _controller,
                  validator: (val) {
                    if (val == '') return '교육 코드를 입력하세요';
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 36),
            CustomSizedBox(
              child: CustomElevatedButton(
                text: '제출하기',
                function: () {
                  final valid = _formKey.currentState!.validate();
                  if ((classData is ClassModel) && (classData.lectureCode == _controller.text) && valid) {
                    ref.read(userProvider.notifier).userAuthorize();
                    context.goNamed(UserPage.routeName);
                  }
                  if ((classData is ClassModel) && (classData.lectureCode != _controller.text) && valid) {
                    _controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '교육 코드가 틀렸습니다. 다시 입력해 주세요',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
