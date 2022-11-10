import 'package:cstarimage_testpage/constants/creidentials.dart';
import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/model/classes_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/screen/instructors_data_read_page.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final classInfo = prefs.getStringList('class');

    //로컬에 이미 데이터가 있으면 로컬에서 가져오기
    if (classInfo == null) {
      print('=======================');
      print('classInfo from Gsheet');
      print('=======================');
      await ref.read(classProvider.notifier).classWorkSheetInit();
      await ref.read(classProvider.notifier).getTodayClassData(DateTime.now());
    } else {
      print('=======================');
      print('classInfo from Local');
      print('=======================');
      getDataFromLocal(classInfo);
    }
  }

  void getDataFromLocal(List<String>? classInfo) async {
    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '이미 ${classInfo![1]} 일자 ${classInfo[4]} 의 강의 코드를 인증 하셨습니다. 다른 강의 코드를 입력하시겠습니까?',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(10)),
              onPressed: () => Navigator.pop(context, true),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '예',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(10)),
              onPressed: () => Navigator.pop(context, false),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '아니요',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        );
      },
    );
    if (!result) {
      goToUserPage();
    }
  }

  void goToUserPage() {
    context.goNamed(UserPage.routeName);
  }

  void saveClassInfo(ClassModel classInfo) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('class', classInfo.propertiesToList());
    } catch (e) {
      ref.read(classProvider.notifier).errorOnSave();
    }
  }

  void checkLectureCode(ClassesModel classesData) {
    bool lectureCodeValidated = false;
    for (var classData in classesData.classData) {
      if (_controller.text == classData.lectureCode) {
        lectureCodeValidated = true;
        saveClassInfo(classData);
        goToUserPage();
      }
    }

    if (!lectureCodeValidated) {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              const SizedBox(height: 24),
              CustomSizedBox(
                child: CustomTextField(
                  hint: classData.error,
                  controller: _controller,
                ),
              ),
              const SizedBox(height: 36),
              CustomSizedBox(
                child: CustomElevatedButton(
                  text: '제출하기',
                  function: () {
                    if (_controller.text == adminPassword) {
                      context.goNamed(InstructorsDataReadPage.routeName);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    classData as ClassesModel;
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
                    if (valid) {
                      checkLectureCode(classData);
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
