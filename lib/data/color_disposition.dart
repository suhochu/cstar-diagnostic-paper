import 'package:cstarimage_testpage/model/lecture_code.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:flutter/material.dart';

import '../constants/data_contants.dart';

class ColorDisposition extends QAndAData<String, List<Selections>> {
  @override
  final Test test = Test.colorDisposition;

  @override
  final SelectionType selectionType = SelectionType.checkBox;

  @override
  final List<String> questions = [
    '자유와 개성 ',
    '책임감 ',
    '적극적인 도전정신 ',
    '박애주의자 ',
    '독립적 사고 ',
    '커뮤니케이션 ',
    '행동대장 (말보단 행동) ',
    '대장부 기질 ',
    '디테일 (ex, 오타 찾기) ',
    '합리적인 사고 ',
    '초현실주의자 ',
    '연민, 동정 ',
    '마이페이스 (마이 웨이) ',
    '절제, 컨트롤 능력 ',
    '목표지향적 ',
    '카운셀러 기질 ',
    '울타리 있는 자유로움 ',
    '빠른 업무처리 ',
    '승부욕 (라이벌의식) ',
    '매사 감사한 마음,예,아니요 ',
    '직관력 (촉) ',
    '평화주의자 ',
    '자기반성 잘함 ',
    '벼락치기 능함 ',
    '예술적 감각, 독창성 ',
    '인간관계 ',
    '일관성 ',
    '뛰어난 언변 ',
    '허무, 허탈감 (공허함) ',
    '감정표현 힘듦 ',
    '개인주의 ',
    '욜로 라이프 (절제된 삶X) ',
    '영적인 이슈 (종교생활) ',
    '중립적인 태도 ',
    '경험주의 ',
    '국보급 친화력 ',
    '외모지상주의 ',
    '능력보단 인성 ',
    '예민, 민감 ',
    '오픈 마인드 (개방적 사고) ',
    '영민, 탐구적 ',
    '천진난만 ',
    '트렌디 함(유행파악 빠름) ',
    '눈썰미 (관찰력) ',
    '신뢰, 믿음 ',
    '즉흥적 (급한 성격) ',
    '변화를 즐김 ',
    '표정관리 못함 ',
    '직설적 ',
    '영웅심리 ',
    '밝고 경쾌 ',
    '왕성한 호기심 ',
    '변화에 대한 두려움 ',
    '소년, 소녀 감성 ',
    '기브 & 테이크 ',
    '유연성 ',
    '신중함 ',
    '대우 받길 원함 ',
    '정보탐구 및 수집 (배움의 즐거움) ',
    '소유욕 (물건, 사람포함) ',
    '솔직한 감정표현 ',
    '소소한(소박함) ',
    '완벽주의자 ',
    '자기방어 ',
    '애정결핍 ',
    '순박함 ',
    '순수한 ',
    '강한 자기주장 ',
    '풍부한 감수성 ',
    '안정지향 ',
    '모 아니면 도 (이분법) ',
    '카리스마 ',
    '로맨티스트 (사랑꾼) ',
    '헌신적 ',
    '정신적인 안정성 ',
    '실천력 ',
    '모성애 ',
    '결속력 ',
    '높은 이상 ',
    '정서적 결핍 ',
  ];

  @override
  final List<String> answers = [
    '예',
    '아니요',
  ];

  @override
  Widget subTitle = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          '각 문항당 최소 2가지 이상의 항목을 선택 바랍니다.',
          style: TextStyle(fontSize: 14),
        ),
      ),
    ],
  );

  @override
  bool validator(List<Selections> result) {
    bool isValid = false;
    for (int i = 0; i < 20; i++) {
      final List<Selections> toBeValidated = [
        result[i],
        result[i + 20],
        result[i + 40],
        result[i + 60],
      ];
      int count = 0;
      for (var i in toBeValidated) {
        if (i == Selections.ndf) count++;
      }
      if (count > 2) break;
      if (i == 19) isValid = true;
    }
    return isValid;
  }
}
