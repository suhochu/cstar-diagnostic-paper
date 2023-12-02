import 'package:cstarimage_testpage/constants/questions.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class PersonalColorSelfTest extends QAndAData<List<Selections>> {
  PersonalColorSelfTest({
    super.test = Test.personalColorSelfTest,
    super.hasIndividualAnswers = true,
  }){
    // length = qPersonalColorSelfTest.length;
    initiatedResultList();
  }

  // @override
  // final bool hasIndividualAnswers = true;
  //
  // @override
  // final Test test = Test.personalColorSelfTest;

  // @override
  // final List<String> questions = [
  //   '피부타입 질문 1 ',
  //   '피부타입 질문 2 ',
  //   '목, 손목 ',
  //   '셔츠 ',
  //   '헤어 ',
  //   '눈동자 ',
  //   '핏줄 ',
  //   '립스틱 ',
  //   '악세사리 ',
  // ];
  //
  // @override
  // final List<List<String>> answers = [
  //   [
  //     '노란기가 많음 ',
  //     '노란기, 붉은기, 모두 동반 ',
  //     '붉은기가 많음 ',
  //   ],
  //   [
  //     '햇볕에 노출되면 그대로 타버리고 다시 원래의 피부로 돌아가는 시간이 오래 걸림 ',
  //     '때에 따라 다름 ',
  //     '햇빛에 노출되면 새빨갛게 붉어졌다가 다시 본연의 피부로 돌아감 ',
  //   ],
  //   [
  //     '베이지 & 옐로우 ',
  //     '모르겠음 ',
  //     '핑크, 붉은기 ',
  //   ],
  //   [
  //     '베이지와 아이보리 셔츠가 더 잘 어울림 ',
  //     '모르겠음 ',
  //     '순백색의 셔츠가 더 잘 어울림 ',
  //   ],
  //   [
  //     '내추럴 브라운 Or 딥 브라운 ',
  //     '모르겠음 ',
  //     '그레이 브라운 (회갈색) or 내추럭 블랙 ',
  //   ],
  //   [
  //     '내추럴 브라운 ',
  //     '딥 브라운 ',
  //     '내추럴 블랙 ',
  //   ],
  //   [
  //     '청녹색 ',
  //     '청녹색 & 청보라 ',
  //     '청보라 (파랑) ',
  //   ],
  //   [
  //     '오렌지, 드라이로즈, 코랄 ',
  //     '모르겠음 ',
  //     '핑크, 체리레드, 마젠타 ',
  //   ],
  //   [
  //     '골드 ',
  //     '로즈골드 ',
  //     '실버 ',
  //   ],
  // ];
}
