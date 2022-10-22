enum Selections { A, B, C, D, E, F }

Selections? stringToSelections(String string) {
  if(string == 'A'){
    return Selections.A;
  }
  if(string == 'B'){
    return Selections.B;
  }
  if(string == 'C'){
    return Selections.C;
  }
  if(string == 'D'){
    return Selections.D;
  }
  if(string == 'E'){
    return Selections.E;
  }
  if(string == 'F'){
    return Selections.F;
  }
  return null;
}


final List<String> genderItems = [
  '남자',
  '여자',
];

final List<String> agesItems = [
  '10-14',
  '15-19',
  '20-24',
  '25-29',
  '30-34',
  '35-39',
  '40-44',
  '45-49',
  '50-54',
  '55-59',
  '60-64',
  '65-69',
  '70이상'
];


List<String?> initialAnswerSheet (int length) {
  return List.generate(length, (index) => null);
}