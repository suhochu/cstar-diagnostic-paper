import 'package:cstarimage_testpage/constants/questions.dart';
import 'package:cstarimage_testpage/model/questions_answers_data.dart';
import 'package:flutter/material.dart';

import '../constants/data_contants.dart';
import '../model/lecture_code.dart';

class LeadershipQuestions extends QAndAData<List<Selections>> {
  LeadershipQuestions({
    super.test = Test.leadershipQuestions,
    super.subTitle = const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '타고난 성격과 습관, 성품에 따라 리더들의 문제해결 방안은 다양하게 나타난다. 당신은 어떤 리더십의 소유자인가? 꼼꼼하게 스스로를 점검해 보자.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  }) {
    explanations = Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 1)),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text('@  전혀 아니다 1점.  대체로 아니다 2점.  보통이다 3점.  대체로 그렇다 4점.  매우 그렇다 5점', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        ],
      ),
    );
    // length = qLeaderShipQuestions.length;
    initiatedResultList();
  }

// @override
// final Test test = Test.leadershipQuestions;

// @override
// final List<String> questions = [
//   '의견 충돌이 있으면 감정적 언쟁보다는 합의점을 찾는다 ',
//   '대화할 때 상대방의 말을 적극적으로 듣는다 ',
//   '상대에게 충고할 때 우선순위를 두어 중요한 것부터 말한다 ',
//   '상대방이 개선될 수 있도록 관심을 가지고 자극한다 ',
//   '같이 진행했던 프로젝트가 좋지 않은 결과를 냈을 때 내가 책임진다 ',
//   '상대가 어떤 계획을 세웠을 때 그것이 잘 실행되고 있는지 관심을 가지고 물어본다 ',
//   '이슈나 관심사에 대해서 상대와 자주 토론하는 시간을 갖는다 ',
//   '어떤 문제가 발생했을 때 상대의 입장에서 생각한다 ',
//   '현실적이고 구체적인 계획을 세운다 ',
//   '상대가 어떤 계획을 실천하려고 할 때 많은 도움을 준다 ',
//   '자주 다른 사람들에게 용기를 주는 행동을 한다 ',
//   '계획을 세우면 실행할 방법(무엇을, 언제, 어디서 등)에 대해서 명확히 한다 ',
//   '하루에 세 번 이상 칭찬한다 ',
//   '상대에게 질문을 많이 한다 ',
//   '상대가 변명을 하거나 고집을 부리는 경우 화를 내지 않고 개선책을 토의한다 ',
//   '상대방의 잘못된 점을 발견했을 때 한 번에 한 가지만 이야기 한다 ',
//   '어떤 계획을 세우고 나면 실천 의지를 주변에 알린다 ',
//   '계획된 일을 실행할 때 방해나 장애물이 생기면 포기하기보다 극복 방법을 먼저 생각한다 ',
//   '나의 행동이 미래에 어떤 결과를 가져올지 생각하면서 신중하게  행동한다 ',
//   '주변에서 일어나는 일에 관심이 많다 ',
//   '해결책을 제시하기보다는 스스로 해결할 수 있도록 돕는다 ',
//   '계획을 행동에 옮기면 어떤 결과가 올 것인지 먼저 상상한다 ',
//   '선입견과 편견이 별로 없다 ',
//   '상대방을 설득하거나 나의 의견을 강요하지 않는다 ',
//   '상대방에게 위기의식을 느끼게 하여 안 좋은 행동을 바꾸기도 한다 ',
// ];
//
// @override
// final List<String> answers = [
//   '전혀 아니다 ',
//   '대체로 아니다 ',
//   '보통이다 ',
//   '대체로 그렇다 ',
//   '매우 그렇다 ',
// ];

// @override
// Widget subTitle = const Padding(
//   padding: EdgeInsets.all(20),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         '타고난 성격과 습관, 성품에 따라 리더들의 문제해결 방안은 다양하게 나타난다. 당신은 어떤 리더십의 소유자인가? 꼼꼼하게 스스로를 점검해 보자.',
//         style: TextStyle(fontSize: 14),
//       ),
//     ],
//   ),
// );
//
// @override
// Widget explanations = Container(
//   decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 1)),
//   width: double.infinity,
//   padding: const EdgeInsets.all(16),
//   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//   child: const Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text('@  셀프 테스트 점수 테이블', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
//       SizedBox(height: 8),
//       Text('1. 각 문항에 해당하는 점수를 다음 테이블의 빈칸에 적는다.', style: TextStyle(fontSize: 12)),
//       SizedBox(height: 8),
//       Text('(예를 들어 1번의 점수는 B란에, 2번의 점수는 A란에 적으면 된다.)', style: TextStyle(fontSize: 12)),
//       SizedBox(height: 8),
//       Text('2. 각 문항의 점수를 합하여 항목별 합계란에 기입한다.', style: TextStyle(fontSize: 12)),
//       SizedBox(height: 8),
//       Text('3. 가장 높은 점수가 자신의 리더십 스타일이다.', style: TextStyle(fontSize: 12)),
//       SizedBox(height: 8),
//       Text('@  전혀 아니다 1점.  대체로 아니다 2점.  보통이다 3점.  대체로 그렇다 4점.  매우 그렇다 5점', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
//     ],
//   ),
// );
}
