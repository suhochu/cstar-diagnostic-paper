import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
import 'package:cstarimage_testpage/repository/google_sheet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';

final testRepositoryProvider = Provider<TestRepository>(
  (ref) => TestRepository(gSheets: ref.read(googleSheetRepository)),
);

class TestRepository {
  TestRepository({
    required this.gSheets,
  });

  final GSheets gSheets;
  Worksheet? testsInfoSheet;

  Future<void> init() async {
    final spreadsheet = await gSheets.spreadsheet(GoogleSheetInfo.spreadsheetId);
    try {
      testsInfoSheet = await spreadsheet.addWorksheet(GoogleSheetInfo.testsSheet);
    } catch (e) {
      testsInfoSheet = spreadsheet.worksheetByTitle(GoogleSheetInfo.testsSheet)!;
    }
  }

  Future<List<Map<String, String>>?> getAllRows() async {
    if(testsInfoSheet == null) return null;
    final List<Map<String, String>>? rows = await testsInfoSheet!.values.map.allRows();
    if (rows == null) return null;
    return rows;
  }
}
