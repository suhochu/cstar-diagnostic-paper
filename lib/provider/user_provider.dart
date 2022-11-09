import 'package:cstarimage_testpage/model/user_model.dart';
import 'package:cstarimage_testpage/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserDataModel>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserNotifier(
    repository: repository,
  );
});

class UserNotifier extends StateNotifier<UserDataModel> {
  final UserRepository repository;

  UserNotifier({
    required this.repository,
  }) : super(
          UserModel.initial(),
        );

  Future<void> userWorkSheetInit() async {
    await repository.init();
  }

  Future<void> userInsert(UserModel user) async {
    final result = await repository.addRow(user.toMap());
    if (result) {
      state = user;
    } else {
      state = UserModelError(error: '서버에 문제가 있습니다. 다시 시도 부탁드립니다.');
    }
  }

  Future<bool> isUserExist(String email) async {
    if (email != '') {
      final userFromRep = await repository.isDataExist(email);
      if (userFromRep != null && userFromRep.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

  Future<UserModel> updateUserState(String email) async {
    UserDataModel userModel;
    final userFromRep = await repository.isDataExist(email);
    userModel = UserModel.fromMap(userFromRep!);
    state = userModel;
    userModel as UserModel;
    return userModel;
  }

  void getUserInfoFromDevice(List<String> classInfo) {
    UserModel userModel = UserModel.fromList(classInfo);
    state = userModel;
  }

  void errorOnSave() {
    state = UserModelError(error: '저장중에 문제가 발생했습니다. 재실행 부탁드립니다.');
  }
}
