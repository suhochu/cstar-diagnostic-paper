import 'package:cstarimage_testpage/model/questions_answers_data.dart';

class NewUserModel {
  final String name;
  final String code;

  const NewUserModel({
    required this.name,
    required this.code,
  });

  factory NewUserModel.init() {
    return const NewUserModel(
      name: '',
      code: '',
    );
  }

  NewUserModel copyWith({
    String? name,
    String? code,
    List<QAndAData>? testList,
  }) {
    return NewUserModel(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}
