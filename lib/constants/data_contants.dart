enum Selections { A, B, C, D, E }


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


List<String> initialAnswerSheet (int length) {
  return List.generate(length, (index) => 'A');
}