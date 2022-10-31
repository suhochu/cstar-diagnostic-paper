import 'dart:math';
import 'package:cstarimage_testpage/model/answer_sheet_model.dart';
import 'package:flutter/material.dart';

class SelfLeaderShipResult {
  static List<String> leaderShipType = ['펀(FUN)형 리더', '경제형 리더', '시인형 리더', '예언가형 리더', '오뚜기형 리더'];
  static List<String> leaderShipExplanation = [
    '''당신은 조직 구성원들의 열정과 에너지를 자발적으로 이끌어내는 데 탁월한 리더이다. 세대 차이를 넘어 구성원들과 함께 공감하며 그들의 눈높이에서 이해하고 동기를 부여한다. 격려와 지원을 아끼지 않는 스타일로 구성원들을 이끌어 가고 구성원들 또한 리더를 믿고 함께하고자 하려는 경향이 강하다. 또한 구성원들에게 가족과 같은 리더이며 동시에 포근하고 포용력 있는 따뜻한 카리스마를 가진 리더로 인정받고 있다. 관계 지향적이기 때문에 성과는 물론, 인재육성과 함께 구성원 스스로가 참여하도록 하고 잠재능력을 이끌어내 계발할 수 있도록 하는 좋은 리더라고 할 수 있다.  그러나 상대를 편안하게 해주는 것이 리더의 전부는 아니다. 만일 질책할 일이 있다면 따끔하게 지적해 개선책을 찾는 것도 당신의 업무성과를 위해서 꼭 필요한 일이다.''',
    '''당신은 핵심을 잘 간파하고 세상과 사회를 보는 예리한 판단력을 가진 리더로 주위의 신뢰를 얻고 있다. 문제에 대한 정확한 상황 판단으로 현실을 직시하며, 구성원 개개인이 갖고 있는 문제와 능력을 이성적으로 파악하는 능력이 뛰어나다. 어떤 행동이나 그 결과에 대한 지식과 경험을 존중하고 핵심을 꿰뚫어보는 능력이 뛰어나 구성원들이나 본인에게 빈틈이 없는 예리한 스타일로 인정받고 있다. 그러나 불필요한 갈등이나 감정을 귀찮아하는 타입이다. 인간관계에 있어서 감정적인 것도 배제할 수 없음을 감안해 직선적인 부분을 자제하는 것이 좋다.''',
    '''당신은 현상과 세상을 다각도로 보는 깨어 있는 리더이다. 현실에 만족하지 않고 어떤 현상의 이면까지도 간파하는 능력이 있어 미래를 예측하고 대비하려고 노력한다. 다양한 관점을 포용하고 탁월한 관찰력과 직관을 가지고 상대를 이해할 줄 아는 리더로 인정받고 있다. 그러나 상대에 따라 직설적인 정답을 제시하거나 경험을 통한 충고를 해줘야 하는 경우도 있음을 잊지 말아야 한다.''',
    '''당신은 체계적이고 계획에 대한 실행력이 뛰어난 리더이다. 주도면밀하며 아이디어가 많고 아이디어를 조직으로 행동으로 계획화하는 것에 능하다. 상상과 생각을 구체화하는 능력이 뛰어나서 현실적으로 가능한 계획을 우선시하고 목표 지향적이므로 감정보다 논리적이고 시스템적인 사고를 선호한다. 당신은 자신의 계획 하에 구성원들의 능력을 구조화시켜 최고로 발휘할 수 있게 하는 장점이 있다. 그러나 계획을 실행함에 있어 수행하는 사람들의 의사를 존중해 줄 필요도 있다. 정해진 계획을 일방적으로 수행하기만 하면 직원들의 반발이나 나태를 불러올 수 있기 때문이다.''',
    '''당신은 유연성이 뛰어난 리더이다. 다양한 구성원의 요구를 조화시키고 갈등 해결능력이 뛰어나며 실패에 대한 두려움보다는 그것을 밑거름으로 변화와 도전을 주도하는 리더로 인정받고 있다. 사람들에 대한 관심을 가지고 열정적으로 리드하기 때문에 직원들이 당신으로부터 관심을 받고 있다는 것을 느끼고 열심히 업무에 임할 수 있게 해준다. 그러나 지나친 관심은 감시로 돌변할 수 있다는 사실에도 주의해야 할 것이다. ''',
  ];

  static List<int> score = [0, 0, 0, 0, 0];

  static List<List<int>> types = const [
    [2, 11, 13, 20, 23],
    [1, 3, 7, 16, 24],
    [4, 8, 14, 19, 25],
    [5, 9, 12, 17, 21],
    [6, 10, 15, 18, 22],
  ];

  static List<SelfLeaderShipResultModel> diagnosis(AnswerSheetModel answerSheet) {
    List<String?> answers = answerSheet.answers;
    List<int> answerNumber = [];

    for (var i in answers) {
      if (i == 'A') {
        answerNumber.add(1);
      } else if (i == 'B') {
        answerNumber.add(2);
      } else if (i == 'C') {
        answerNumber.add(3);
      } else if (i == 'D') {
        answerNumber.add(4);
      } else if (i == 'E') {
        answerNumber.add(5);
      } else {
        print('nothing have!!');
      }
    }

    score = [0, 0, 0, 0, 0];

    // TypeA
    for (var j = 0; j < 5; j++) {
      for (var i = 0; i < 5; i++) {
        score[j] = score[j] + answerNumber[types[j][i] - 1];
      }
    }

    List<int> decidedIndex = decideWhichTypeIsMaxScore(score);
    List<SelfLeaderShipResultModel> decidedTypes = [];
    for (var i in decidedIndex) {
      SelfLeaderShipResultModel selfLeaderShipResult = SelfLeaderShipResultModel(
        type: leaderShipType[i],
        explanation: leaderShipExplanation[i],
      );
      decidedTypes.add(selfLeaderShipResult);
    }
    return decidedTypes;
  }

  static List<int> decideWhichTypeIsMaxScore(List<int> score) {
    final int maxScore = score.reduce(max);
    List<int> indexAtMaxValue = [];
    for (int i = 0; i < score.length; i++) {
      if (score[i] == maxScore) {
        indexAtMaxValue.add(i);
      }
    }
    return indexAtMaxValue;
  }

  static Widget customListTile(int index){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          '${leaderShipType[index]} : ${score[index]}',
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        );
  }

  static Widget buildWidget({
    required List<SelfLeaderShipResultModel> selfLeaderShipResult,
    required BuildContext context,
    required String userName,
    required List<int> score,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 5,
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: selfLeaderShipResult.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ExpansionTile(
                title: Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    '$userName님의 \n리더십 유형 진단 결과',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                children: [
                  const SizedBox(height: 8.0),
                  const Text(
                    '각 유형별 진단 점수',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 8.0),
                  customListTile(0),
                  customListTile(1),
                  customListTile(2),
                  customListTile(3),
                  customListTile(4),
                  const SizedBox(height: 16.0),
                ],
              );
            }

            return ListTile(
              title: Text(
                '결과 : ${selfLeaderShipResult[index - 1].type}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              contentPadding: const EdgeInsets.all(16.0),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  selfLeaderShipResult[index - 1].explanation,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
