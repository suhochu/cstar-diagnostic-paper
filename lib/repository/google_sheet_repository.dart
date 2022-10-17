import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';

final googleSheetRepository = StateProvider<GSheets>(
      (ref) => GSheets(GoogleSheetInfo.credentials),
);