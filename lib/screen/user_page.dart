import 'dart:async';

import 'package:cstarimage_testpage/constants/data_contants.dart';
import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/provider/user_provider.dart';
import 'package:cstarimage_testpage/screen/test_selection_page.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/custom_drop_down_button.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Timer? _deBounce;
  String? _gender;
  String? _ages;

  @override
  void initState() {
    super.initState();
    isUserExistInLocal();
    _emailController.addListener(() {
      _onSearchChanged(_emailController.text);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_deBounce != null) {
      _deBounce!.cancel();
    }
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
  }

  Future<AppBar?> initializeAppbar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final classInfo = prefs.getStringList('class');
    if (classInfo == null) return null;
    return AppBar(
      title: Text(
        '${classInfo[1]} 일자 ${classInfo[4]} 에서의 강의에 참여해 주셔서 감사합니다.',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      backgroundColor: Colors.redAccent,
    );
  }

  Future<void> isUserExistInLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getStringList('user');

    //로컬에 이미 데이터가 있으면 로컬에서 가져오기
    if (userInfo != null) {
      ref.read(userProvider.notifier).getUserInfoFromDevice(userInfo);
      print('=======================');
      print('UserInfo from Local');
      print('=======================');

      bool isUserValid = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'User 정보가 이미 존재 합니다. User 정보를 재입력 하시겠습니까?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
          ) ??
          false;
      if (!isUserValid) {
        goToTestSelectionPage();
      }
    }
  }

  _onSearchChanged(String text) {
    if (_deBounce?.isActive ?? false) _deBounce?.cancel();
    _deBounce = Timer(const Duration(milliseconds: 500), () async {
      if (await checkUserInfoFromDB(_emailController.text)) {
        final user = await ref.read(userProvider.notifier).updateUserState(_emailController.text);
        saveUser(user);
        goToTestSelectionPage();
      } else {
        _deBounce?.cancel();
      }
    });
  }

  void goToTestSelectionPage() {
    context.goNamed(TestSelectionPage.routeName);
  }

  Future<void> init() async {
    await ref.read(userProvider.notifier).userWorkSheetInit();
  }

  Future<void> userInsert(UserModel user) async {
    await ref.read(userProvider.notifier).userInsert(user);
  }

  void saveUser(UserModel user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('user', user.propertiesToList());
    } catch (e) {
      ref.read(userProvider.notifier).errorOnSave();
    }
  }

  Future<bool> checkUserInfoFromDB(String email) async {
    String userEmail = _emailController.text;
    final bool isUserExist = await ref.read(userProvider.notifier).isUserExist(userEmail);
    bool isUserValid = false;
    if (isUserExist) {
      isUserValid = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  '$email을 사용하는 회원님이 이미 데이터 베이스에 존재합니다. 데이터 베이스에서 불러올까요?',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(10)),
                    onPressed: () => Navigator.pop(context, true),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '불러오기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(10)),
                    onPressed: () => Navigator.pop(context, false),
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '불러오지 않기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              );
            },
          ) ??
          false;
    }
    return isUserValid;
  }

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = ref.watch(userProvider);

    if (userData is UserModelError) {
      return DefaultLayout(
        child: Center(
          child: Text(
            userData.error,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return DefaultLayout(
      appbar: initializeAppbar(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                const SizedBox(height: 40),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: 'E-mail 을 입력하세요',
                    label: 'E-mail',
                    maxLength: 40,
                    controller: _emailController,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 24),
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
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 24),
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
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 24),
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
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
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
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                CustomSizedBox(
                  child: CustomElevatedButton(
                    function: () async {
                      bool valid = _formKey.currentState!.validate();
                      if (valid) {
                        UserModel user = UserModel(
                            name: _nameController.text.trim(),
                            company: _companyController.text.trim(),
                            email: _emailController.text.trim(),
                            ages: _ages!,
                            gender: _gender!);
                        userInsert(user);
                        saveUser(user);
                        goToTestSelectionPage();
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
