import 'package:cstarimage_testpage/constants/credential.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';

final googleSheetRepository = StateProvider<GSheets>(
  (ref) => GSheets(CstarDiagGsheetAPIConfig.credentials),
);
