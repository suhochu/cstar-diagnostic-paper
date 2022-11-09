import 'package:cstarimage_testpage/constants/creidentials.dart';
import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/classes_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/screen/instructors_data_read_page.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/screen/user_page.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/buttons.dart';

class ClassPage extends ConsumerStatefulWidget {
  static String get routeName => 'MainPage';

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
    isAlreadyAuthorized();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void isAlreadyAuthorized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final classInfo = prefs.getStringList('class');
    final userInfo = prefs.getStringList('user');

    //로컬에 이미 데이터가 있으면 로컬에서 가져오기
    if (classInfo != null) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: userInfo == null
                ? const Text(
                    '이미 오늘의 코드를 인증 하셨습니다. User 정보 입력 페이지로 이동합니다.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  )
                : const Text(
                    '이미 오늘의 코드를 인증 하셨습니다. User 정보 입력 페이지 혹은 진단지 선택 페이지로 이동합니다.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(10)),
                onPressed: () => context.goNamed(UserPage.routeName),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'User 정보 입력',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              if (userInfo != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(10)),
                  onPressed: () => context.goNamed(TestSelectionPage.routeName),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      '진단지 선택',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    }
  }

  Future<void> init() async {
    await ref.read(classProvider.notifier).classWorkSheetInit();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final classInfo = prefs.getStringList('class');

    //로컬에 이미 데이터가 있으면 로컬에서 가져오기
    if (classInfo == null) {
      print('=======================');
      print('classInfo from Gsheet');
      print('=======================');
      await ref.read(classProvider.notifier).getTodayClassData(DateTime.now());
    } else {
      print('=======================');
      print('classInfo from Local');
      print('=======================');
      ref.read(classProvider.notifier).getTodayClassFromDevice(classInfo);
    }
  }

  void saveClassInfo(ClassModel classInfo) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('class', classInfo.propertiesToList());
    } catch (e) {
      ref.read(classProvider.notifier).errorOnSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ClassesDataModel classData = ref.watch(classProvider);
    final Size size = MediaQuery.of(context).size;

    if (classData is ClassesModelLoading) {
      return DefaultLayout(
        child: Stack(
          children: [
            Positioned(
              bottom: size.height / 7,
              left: size.width / 2 - 50,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (classData is ClassesModelError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            classData.error,
            style: const TextStyle(
              fontSize: 18,
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
                  obscureText: true,
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
                  if (_controller.text == adminPassword) {
                    context.goNamed(InstructorsDataReadPage.routeName);
                  } else {
                    final valid = _formKey.currentState!.validate();
                    if ((classData is ClassesModel) && (classData.classData[0].lectureCode == _controller.text) && valid) {
                      saveClassInfo(classData.classData[0]);
                      context.goNamed(UserPage.routeName);
                    }
                    if ((classData is ClassesModel) && (classData.classData[0].lectureCode != _controller.text) && valid) {
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
