abstract class UserDataModel {}

class UserModelError extends UserDataModel {
  String error;

  UserModelError({
    required this.error,
  });
}

class UserModel extends UserDataModel {
  String name;
  String company;
  String email;
  String gender;
  String ages;

  UserModel({
    required this.name,
    required this.company,
    required this.email,
    required this.gender,
    required this.ages,
  });

  factory UserModel.initial() {
    return UserModel(
      name: '',
      company: '',
      email: '',
      gender: '',
      ages: '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'company': company,
      'email': email,
      'gender': gender,
      'ages': ages,
    };
  }

  factory UserModel.fromMap(Map<String, String> map) {
    return UserModel(
      name: map['name'] as String,
      company: map['company'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      ages: map['ages'] as String,
    );
  }

  UserModel copyWith({
    String? name,
    String? company,
    String? email,
    String? gender,
    String? ages,
  }) {
    return UserModel(
      name: name ?? this.name,
      company: company ?? this.company,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      ages: ages ?? this.ages,
    );
  }

  factory UserModel.fromList(List<String> list) {
    return UserModel(
      name: list[0],
      company: list[1],
      email: list[2],
      gender: list[3],
      ages: list[4],
    );
  }

  List<String> propertiesToList() {
    return [name, company, email, gender, ages];
  }

  @override
  String toString() {
    return 'UserModel{name: $name, company: $company, email: $email, gender: $gender, ages: $ages}';
  }
}
