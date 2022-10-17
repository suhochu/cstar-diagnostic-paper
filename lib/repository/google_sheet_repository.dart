import 'package:cstarimage_testpage/constants/creidentials.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';

final googleSheetRepository = StateProvider<GSheets>(
      (ref) => GSheets(credentials),
);