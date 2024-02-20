import 'package:cstarimage_testpage/routes/qlevar_routes.dart';
import 'package:cstarimage_testpage/utils/shared_preference.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';

// import 'package:go_router/go_router.dart';

import '../../widgets/buttons.dart';

class CodeInsertPage extends StatelessWidget {
  CodeInsertPage({super.key});

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void saveData() async {
    await SharedPreferenceUtil.init();
    await SharedPreferenceUtil.saveString(key: 'name', data: _nameController.text);
    await SharedPreferenceUtil.saveString(key: 'code', data: _codeController.text);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('name', _nameController.text);
    // await prefs.setString('code', _codeController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(),
              CustomSizedBox(
                child: CustomTextField(
                  hint: '이름을 입력하세요',
                  label: '이름',
                  controller: _nameController,
                  obscureText: false,
                  validator: (val) {
                    if (val == '') return '이름을 입력하세요';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              CustomSizedBox(
                child: CustomTextField(
                  hint: '교육 코드를 입력하세요',
                  label: '교육 코드',
                  controller: _codeController,
                  obscureText: false,
                  validator: (val) {
                    if (val == null || val == '') return '교육 코드를 입력하세요';
                    if (!(val.contains('c') ||
                        val.contains('d') ||
                        val.contains('e') ||
                        val.contains('l') ||
                        val.contains('n') ||
                        val.contains('p') ||
                        val.contains('s') ||
                        val.contains('r'))) return '올바른 코드를 입력하세요';
                    // final String code = val.substring(0, 8);
                    // if (code != '20230725') return '교육 코드를 잘 못 입력 하셨습니다.';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 36),
              CustomSizedBox(
                child: CustomElevatedButton(
                    text: '제출하기',
                    function: () async {
                      final valid = _formKey.currentState!.validate();
                      if (valid) {
                        saveData();
                        QR.toName(AppRoutes.testSelectionPage);
                        // context.goNamed('diagnosisSelectionPage');
                      }
                    }),
              ),
              const SizedBox(height: 30),
              const Text(
                'Released at 20240220',
                style: TextStyle(color: Colors.black12),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
