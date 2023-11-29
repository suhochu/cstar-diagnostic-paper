// import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
// import 'package:cstarimage_testpage/repository/google_sheet_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gsheets/gsheets.dart';
//
// final questionsRepositoryProvider = Provider<QuestionsRepository>(
//   (ref) => QuestionsRepository(gSheets: ref.read(googleSheetRepository)),
// );
//
// class QuestionsRepository {
//   QuestionsRepository({
//     required this.gSheets,
//   });
//
//   final GSheets gSheets;
//   Worksheet? testsInfoSheet;
//
//   Future<void> getQuestionsSheet(String sheet) async {
//     final spreadsheet = await gSheets.spreadsheet(GoogleSheetInfo.spreadsheetId);
//     try {
//       testsInfoSheet = await spreadsheet.addWorksheet(sheet);
//     } catch (e) {
//       testsInfoSheet = spreadsheet.worksheetByTitle(sheet)!;
//     }
//   }
//
//   Future<List<Map<String, String>>?> getAllRows() async {
//     if (testsInfoSheet == null) return null;
//     final List<Map<String, String>>? rows = await testsInfoSheet!.values.map.allRows();
//     if (rows == null) return null;
//     return rows;
//   }
// }
