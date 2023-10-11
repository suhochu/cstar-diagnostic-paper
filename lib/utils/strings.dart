List<String> stringToList(String string, {bool subtract = false}) {
  String returnedString = string;
  if (subtract) {
    returnedString = string.substring(1, string.length - 1);
  }
  return returnedString.split(',').map((string) => string.trim()).toList();
}

String getYearMonthDate(DateTime dateTime) {
  return dateTime.toString().split(' ')[0];
}

String? validateEmail(String? value) {
  String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return '이메일 주소를 입력하세요';
  } else {
    return null;
  }
}
