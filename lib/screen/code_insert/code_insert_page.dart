import 'package:cstarimage_testpage/model/new_user_model.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

import '../../provider/new_user_provider.dart';
import '../../widgets/buttons.dart';

class CodeInsertPage extends ConsumerWidget {
  CodeInsertPage({super.key});

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    if (val.length <= 8) return '교육 코드의 길이가 짧습니다.';
                    final String code = val.substring(0, 8);
                    if (code != '20230725') return '교육 코드를 잘 못 입력 하셨습니다.';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 36),
              CustomSizedBox(
                child: CustomElevatedButton(
                    text: '제출하기',
                    function: () {
                      final valid = _formKey.currentState!.validate();
                      if (valid) {
                        ref.read(newUserProvider.notifier).updateModel(NewUserModel(
                              code: _codeController.text,
                              name: _nameController.text,
                            ));
                        // Navigator.of(context).pushNamed("/diagnosisSelectionPage");
                        context.goNamed('diagnosisSelectionPage');
                      }
                    }),
              ),
              const SizedBox(height: 30),
              const Text(
                'Released at 20231211',
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
