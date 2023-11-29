import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:flutter/material.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class Pitr extends QAndAData<String, List<Selections>> {
  @override
  final Test test = Test.pitr;

  @override
  final List<String> questions = [
    '비가 없다 ',
    '비가 있다 ',
    '비가 많다 ',
    '비의 스타일 (ex 물방울, 회오리 등) ',
    '비의 방향 (ex 오른쪽, 왼쪽 등) ',
    '비가 몸에 닿았다 ',
    '사람이 젖었다 ',
    '바람이 분다 ',
    '물웅덩이 개수 ',
    '물웅덩이에 서 있다 ',
    '다양한 비 스타일 ',
    '다중 강수 ',
    '번개가 친다 ',
    '번개에 맞았다 ',
    '구름 ',
    '먹구름 ',
    '보호장비가 있다 (ex 처마, 집, 차 등) ',
    '우산이 있다 ',
    '우산을 들고 있다 ',
    '다른 보호 장비 ',
    '적절한 크기의 보호물 ',
    '보호 장비가 이상 없다 ',
    '비옷 ',
    '장화 ',
    '인물이 옷을 입고 있다 ',
    '얼굴 전체가 보인다 ',
    '얼굴의 미소 ',
    '중심에 있는 인물 ',
    '인물의 크다 ',
    '전체 인물을 다 그렸다 ',
    '선의 질 (필압이 균형적) ',
    '선의 질 (균일, 연속적, 끊김 없음) ',
    '나체 ',
    '신체일부의 생략 : 머리 ',
    '신체일부의 생략 : 눈 ',
    '신체일부의 생략 : 코 ',
    '신체일부의 생략 : 입 ',
    '신체일부의 생략 : 몸통 ',
    '신체일부의 생략 : 목 ',
    '신체일부의 생략 : 팔 ',
    '신체일부의 생략 : 손 ',
    '신체일부의 생략 : 손가락 ',
    '신체일부의 생략 : 다리 ',
    '신체일부의 생략 : 발 ',
    '치아가 보인다 ',
  ];

  @override
  Widget subTitle = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '각 문항이 해당 사항이 있으면 체크 부탁드립니다.',
          style: TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}
