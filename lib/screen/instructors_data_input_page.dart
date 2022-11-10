import 'package:cstarimage_testpage/layout/default_layout.dart';
import 'package:cstarimage_testpage/model/class_model.dart';
import 'package:cstarimage_testpage/provider/class_provider.dart';
import 'package:cstarimage_testpage/utils/strings.dart';
import 'package:cstarimage_testpage/widgets/buttons.dart';
import 'package:cstarimage_testpage/widgets/sizedbox.dart';
import 'package:cstarimage_testpage/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:collection/collection.dart';

class InstructorsDataInputPage extends ConsumerStatefulWidget {
  static String get routeName => 'InstructorsDataInputPage';

  InstructorsDataInputPage({Key? key, this.classModel}) : super(key: key);
  ClassModel? classModel;

  @override
  ConsumerState<InstructorsDataInputPage> createState() => _InstructorsPageState();
}

class _InstructorsPageState extends ConsumerState<InstructorsDataInputPage> {
  final _formKey = GlobalKey<FormState>();
  static final List<String> _lectureName = [
    '스트레스 진단',
    '자존감 진단',
    '리더십 유형',
    'EIC 이미지 셀프 진단',
    'Color Disposition Checklist',
    'PITR',
    'disposition Test',
  ];
  static final List<Color> _colors = [
    Colors.brown,
    Colors.blueGrey,
    Colors.lightGreen,
    Colors.orange,
    Colors.indigo,
    Colors.lime,
    Colors.teal
  ];

  final _items = _lectureName.map((lecture) => MultiSelectItem<String>(lecture, lecture)).toList();

  final List<String> _selected = [];
  final List<Widget> _chipSelected = [];

  late final TextEditingController _classRoomController;
  late final TextEditingController _companyController;
  late final TextEditingController _lectureCodeController;
  late final TextEditingController _dateDateController;
  late final TextEditingController _diagnosisTestController;

  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    _classRoomController = TextEditingController();
    _companyController = TextEditingController();
    _lectureCodeController = TextEditingController();
    _dateDateController = TextEditingController();
    _diagnosisTestController = TextEditingController();

    if (widget.classModel != null) {
      initializeTextFieldWithClassModel();
      isUpdate = true;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        init();
        if (widget.classModel == null) {
          showDatePickerDialogPop(context);
        }
      },
    );
  }

  Future<void> init() async {
    await ref.read(classProvider.notifier).classWorkSheetInit();
  }

  void initializeTextFieldWithClassModel() {
    _classRoomController.text = widget.classModel?.classRoom ?? '';
    _companyController.text = widget.classModel?.place ?? '';
    _lectureCodeController.text = widget.classModel?.lectureCode ?? '';
    _dateDateController.text = widget.classModel?.testDate ?? '';
    _selected.addAll(widget.classModel?.accessibleTests ?? []);
    _chipSelected.addAll(_selected.mapIndexed((index, element) => chip(element, _colors[index])).toList());
    diagnosticTestsSelected();
  }

  @override
  void dispose() {
    _classRoomController.dispose();
    _companyController.dispose();
    _lectureCodeController.dispose();
    _dateDateController.dispose();
    _diagnosisTestController.dispose();
    super.dispose();
  }

  void clearTextField() {
    _classRoomController.clear();
    _companyController.clear();
    _lectureCodeController.clear();
    _dateDateController.clear();
    _diagnosisTestController.clear();
    for (var i in _items) {
      i.selected = false;
    }
    setState(() {
      _selected.clear();
      _chipSelected.clear();
    });
  }

  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<String>(
          title: const Text(
            '강의에 이용할 진단지를 선택하세요',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.redAccent),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: 400,
          items: _items,
          initialValue: _selected,
          onConfirm: (values) {
            _selected.clear();
            _selected.addAll(values);
            setState(() {
              _chipSelected.clear();
              _chipSelected.addAll(_selected.mapIndexed((index, element) => chip(element, _colors[index])).toList());
            });
          },
          checkColor: Colors.red,
          unselectedColor: Colors.black,
          selectedColor: Colors.transparent,
          cancelText: const Text(
            '취소',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.redAccent),
          ),
          confirmText: const Text(
            '선택',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.redAccent),
          ),
        );
      },
    );
    diagnosticTestsSelected();
  }

  void diagnosticTestsSelected() {
    if (_selected.isNotEmpty) {
      _diagnosisTestController.text = '진단지를 재선택 하려면 클릭하세요';
    } else {
      _diagnosisTestController.clear();
    }
  }

  void showDatePickerDialogPop(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    setState(() {
      if (selectedDate != null) {
        _dateDateController.text = getYearMonthDate(selectedDate);
      }
    });
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: const EdgeInsets.all(5.0),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: const EdgeInsets.all(6.0),
    );
  }

  void showSuccessDialog(ClassModel classModel) async {
    String operation;
    if (isUpdate) {
      operation = '수정';
    } else {
      operation = '입력';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text('${classModel.testDate} 자 ${classModel.place} 강의 정보가 $operation 되었습니다.'),
      ),
    );
  }

  void lectureCodeDuplicated(ClassModel classModel) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
            '${classModel.testDate} 자 ${classModel.place} 강의 정보의 Lecture Code 가 중복 되었습니다. 중복 되지 않게 Lecture Code 를 지정해 주세요'),
      ),
    );
  }

  void pop() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                const SizedBox(height: 40),
                Text(
                  isUpdate ? '강의 정보 수정' : '강의 정보 입력',
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    showDatePickerDialogPop(context);
                  },
                  child: AbsorbPointer(
                    child: CustomSizedBox(
                      child: CustomTextField(
                        hint: '강의 날짜를 선택하세요',
                        label: '강의 날짜',
                        controller: _dateDateController,
                        validator: (val) {
                          if (val == '' || val == 'null') {
                            return '강의 날짜를 선택하세요';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        // enabled: false,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: '회사 이름을 입력하세요',
                    label: '회사',
                    controller: _companyController,
                    validator: (val) {
                      if (val == '') {
                        return '회사 이름을 입력하세요';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 24),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: '강의 장소를 입력하세요',
                    label: '강의실',
                    controller: _classRoomController,
                    validator: (val) {
                      if (val == '') {
                        return '강의 장소를 입력하세요';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 24),
                // const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    _showMultiSelect(context);
                  },
                  child: AbsorbPointer(
                    child: CustomSizedBox(
                      child: CustomTextField(
                        hint: '수행할 진단지를 선택하세요',
                        label: '진단지',
                        controller: _diagnosisTestController,
                        validator: (val) {
                          if (val == '') {
                            return '수행할 진단지를 선택하세요';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ),
                ),
                CustomSizedBox(
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: _chipSelected,
                  ),
                ),
                const SizedBox(height: 40),
                CustomSizedBox(
                  child: CustomTextField(
                    hint: '강의 코드를 입력하세요',
                    label: '강의 코드',
                    controller: _lectureCodeController,
                    validator: (val) {
                      if (val == '') {
                        return '강의 코드를 입력하세요';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 40),
                CustomSizedBox(
                  child: CustomElevatedButton(
                    function: () async {
                      bool valid = _formKey.currentState!.validate();
                      if (valid) {
                        final classModel = ClassModel(
                          no: isUpdate
                              ? widget.classModel?.no ?? -1
                              : await ref.read(classProvider.notifier).getLastClassIndex() + 1,
                          lectureCode: _lectureCodeController.text,
                          testDate: _dateDateController.text,
                          accessibleTests: _selected,
                          classRoom: _classRoomController.text,
                          place: _companyController.text,
                        );
                        bool isLectureCodeDuplicated =
                            await ref.read(classProvider.notifier).checkLectureCodeDuplicated(classModel);
                        if (!isLectureCodeDuplicated) {
                          bool result = false;
                          if (isUpdate) {
                            result = await ref.read(classProvider.notifier).insertClassByDate(classModel);
                            pop();
                          } else {
                            result = await ref.read(classProvider.notifier).addRow(classModel);
                          }
                          if (result) {
                            showSuccessDialog(classModel);
                            clearTextField();
                          }
                        } else {
                          lectureCodeDuplicated(classModel);
                        }
                      }
                    },
                    text: isUpdate ? '수정하기' : '입력하기',
                  ),
                ),
                const SizedBox(height: 40),
                CustomSizedBox(
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return CustomElevatedButton(
                        function: () async {
                          pop();
                        },
                        text: '이전 화면으로 돌아가기',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
