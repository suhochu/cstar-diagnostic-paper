import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/classes_model.dart';
import 'package:cstarimage_testpage/provider/class_editing_provider.dart';
import 'package:cstarimage_testpage/screen/instructors_page/instructors_data_input_page.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InstructorsDataReadPage extends ConsumerStatefulWidget {
  const InstructorsDataReadPage({Key? key}) : super(key: key);

  static String get routeName => 'InstructorsDataReadPage';

  @override
  ConsumerState<InstructorsDataReadPage> createState() => _InstructorsDataReadPageState();
}

class _InstructorsDataReadPageState extends ConsumerState<InstructorsDataReadPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  Future<void> init() async {
    await ref.read(classEditingProvider.notifier).classWorkSheetInit();
    await ref.read(classEditingProvider.notifier).gelAllClasses();
  }

  int compareFromToday(String date) {
    final today = getYearMonthDate(DateTime.now());
    return date.compareTo(today);
  }

  Color selectColor(int select) {
    if (select == -1) {
      return Colors.black12;
    } else if (select == 1) {
      return Colors.white;
    }
    return Colors.amberAccent;
  }

  @override
  Widget build(BuildContext context) {
    final ClassesDataModel classesData = ref.watch(classEditingProvider);
    final Size size = MediaQuery.of(context).size;

    if (classesData is ClassesModelLoading) {
      return DefaultLayout(
        child: Stack(
          children: [
            Positioned(
              bottom: size.height / 7,
              left: size.width / 2 - 50,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
    }

    classesData as ClassesModel;
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView.builder(
          itemCount: classesData.classData.length + 2,
          itemBuilder: (context, index) {
            String accessibleTests = '';
            if (index < classesData.classData.length) {
              accessibleTests = classesData.classData[index].accessibleTests.toString();
            }
            if (index == classesData.classData.length) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  tileColor: Colors.redAccent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  leading: const Icon(
                    Icons.add_circle_outline,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  title: const Text('새로운 강의 입력', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white)),
                  onTap: () {
                    context.pushNamed(InstructorsDataInputPage.routeName);
                  },
                ),
              );
            }
            if (index == classesData.classData.length + 1) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  tileColor: Colors.redAccent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                  leading: const Icon(
                    Icons.home,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  title: const Text('메인 화면으로 돌아가기', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white)),
                  onTap: () {
                    context.goNamed('/');
                  },
                ),
              );
            }

            final isPast = compareFromToday(classesData.classData[index].testDate);
            Color color = selectColor(isPast);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                tileColor: color,
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                onTap: isPast == -1
                    ? null
                    : () {
                        context.pushNamed(
                          InstructorsDataInputPage.routeName,
                          extra: classesData.classData[index],
                        );
                      },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '강의 날짜 : ${classesData.classData[index].testDate}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isPast == -1 ? null : Colors.redAccent),
                        ),
                        Text(
                          '수업 코드 : ${classesData.classData[index].lectureCode}',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: isPast == -1 ? null : Colors.black45),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '회사명 : ${classesData.classData[index].place}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '강의 장소 : ${classesData.classData[index].classRoom}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '진단지 유형 : ${accessibleTests.substring(1, accessibleTests.length - 1)}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isPast == -1 ? null : Colors.teal),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
