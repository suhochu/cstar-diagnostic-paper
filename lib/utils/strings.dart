List<String> stringToList(String string){
  final list = string.split(',');
  list.first = list.first.trim();
  list.last = list.last.trim();
  return list;
}

String getYearMonthDate(DateTime dateTime){
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