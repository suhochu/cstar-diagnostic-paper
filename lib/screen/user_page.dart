import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/provider/answer_sheet_provider.dart';
import 'package:cstarimage_testpage/provider/user_provider.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/custom_drop_down_button.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class UserPage extends ConsumerStatefulWidget {
  static String get routeName => 'UserInputPage';

  const UserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UserPage> createState() => _UserInputPageState();
}

class _UserInputPageState extends ConsumerState<UserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _gender;
  String? _ages;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    await ref.read(userProvider.notifier).userWorkSheetInit();
  }

  Future<void> userInsert(UserModel user) async {
    await ref.read(userProvider.notifier).userInsert(user);
  }

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = ref.watch(userProvider);


    if (userData is UserModelUnAuthorized) {
      return DefaultLayout(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '오늘의 교육 코드가 인증 되지 않았습니다.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '인증 페이지로 돌아가십시요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        context.goNamed('/');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            '인증 페이지',
                            style: TextStyle(fontSize: 20),
                          ))),
                ]),
          ),
        ),
      );
    }

    if (userData is UserModelError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            userData.error,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                const SizedBox(height: 60),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: '이름을 입력하세요',
                    label: '이름',
                    controller: _nameController,
                    validator: (val) {
                      if (val == '') {
                        return '이름을 입력하세요';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 36),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: '회사을 입력하세요',
                    label: '회사',
                    controller: _companyController,
                    validator: (val) {
                      if (val == '') {
                        return '회사을 입력하세요';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 36),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: 'E-mail 을 입력하세요',
                    label: 'E-mail',
                    maxLength: 40,
                    controller: _emailController,
                    validator: validateEmail,
                  ),
                ),
                const SizedBox(height: 36),
                CustomSizedBox(
                  child: CustomDropDownButton(
                    hint: '성별을 선택하세요',
                    items: genderItems,
                    onSave: (value) {
                      _gender = value.toString();
                    },
                    onChanged: (value) {
                      _gender = value.toString();
                    },
                    validator: (val) {
                      if (val == null) {
                        return '성별을 선택하세요';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 60),
                CustomSizedBox(
                  child: CustomDropDownButton(
                    hint: '나이대을 선택하세요',
                    items: agesItems,
                    onSave: (value) {
                      _ages = value.toString();
                    },
                    onChanged: (value) {
                      _ages = value.toString();
                    },
                    validator: (val) {
                      if (val == null) {
                        return '나이대를 선택하세요';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 60),
                CustomSizedBox(
                  child: CustomElevatedButton(
                    function: (userData is UserModelLoading)
                        ? null
                        : () {
                            bool valid = _formKey.currentState!.validate();
                            if (valid) {
                              UserModel user = UserModel(
                                  name: _nameController.text.trim(),
                                  company: _companyController.text.trim(),
                                  email: _emailController.text.trim(),
                                  ages: _ages!,
                                  gender: _gender!);
                              userInsert(user);
                              context.goNamed(TestSelectionPage.routeName);
                            }
                          },
                    text: '입장하기',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
