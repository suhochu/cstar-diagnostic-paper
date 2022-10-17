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
          UserModelUnAuthorized(),
        );

  void userUnAuthorize() {
    state = UserModelUnAuthorized();
  }

  void userAuthorize() {
    state = UserModelAuthorized();
  }

  Future<void> userWorkSheetInit() async {
    await repository.init();
  }

  Future<void> userInsert(UserModel user) async {
    state = UserModelLoading();
    UserDataModel userModel;
    final userFromRep = await repository.isDataExist(user.email);
    // todo 기존에 있던 유저라면 스넥바를 띄워서 기존 정보를 쓸지 확인
    if (userFromRep != null && userFromRep.isEmpty) {
      userModel = UserModel.fromMap(userFromRep);
      state = userModel;
    }
    final result = await repository.addRow(user.toMap());
    if (result) {
      state = user;
    } else {
      state = UserModelError(error: '서버에 문제가 있습니다. 다시 시도 부탁드립니다.');
    }
  }
}
