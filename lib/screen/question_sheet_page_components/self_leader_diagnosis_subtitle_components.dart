import 'package:flutter/material.dart';

class SelfTestDiagnosisPageComponent {
  static Widget subtitle = Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '타고난 성격과 습관, 성품에 따라 리더들의 문제해결 방안은 다양하게 나타난다. 당신은 어떤 리더십의 소유자인가? 꼼꼼하게 스스로를 점검해 보자.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );

  static Widget explanations = Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 1)),
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('@  셀프 테스트 점수 테이블', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        SizedBox(height: 8),
        Text('1. 각 문항에 해당하는 점수를 다음 테이블의 빈칸에 적는다.', style: TextStyle(fontSize: 12)),
        SizedBox(height: 8),
        Text('(예를 들어 1번의 점수는 B란에, 2번의 점수는 A란에 적으면 된다.)', style: TextStyle(fontSize: 12)),
        SizedBox(height: 8),
        Text('2. 각 문항의 점수를 합하여 항목별 합계란에 기입한다.', style: TextStyle(fontSize: 12)),
        SizedBox(height: 8),
        Text('3. 가장 높은 점수가 자신의 리더십 스타일이다.', style: TextStyle(fontSize: 12)),
        SizedBox(height: 8),
        Text('@  전혀 아니다 1점.  대체로 아니다 2점.  보통이다 3점.  대체로 그렇다 4점.  매우 그렇다 5점',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
      ],
    ),
  );
}
