// import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
// import 'package:cstarimage_testpage/repository/google_sheet_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gsheets/gsheets.dart';
//
// final classRepositoryProvider = Provider<ClassRepository>(
//   (ref) => ClassRepository(gSheets: ref.read(googleSheetRepository)),
// );
//
// class ClassRepository {
//   ClassRepository({
//     required this.gSheets,
//   });
//
//   final GSheets gSheets;
//   Worksheet? classInfoSheet;
//
//   Future<void> init() async {
//     final spreadsheet = await gSheets.spreadsheet(GoogleSheetInfo.spreadsheetId);
//     try {
//       classInfoSheet = await spreadsheet.addWorksheet(GoogleSheetInfo.classSheet);
//     } catch (e) {
//       classInfoSheet = spreadsheet.worksheetByTitle(GoogleSheetInfo.classSheet)!;
//     }
//   }
//
//   Future<List<Map<String, String>>?> getAllDate() async {
//     if (classInfoSheet == null) return null;
//     final row = await classInfoSheet!.values.map.allRows();
//     if (row != null) {
//       return row;
//     } else {
//       return null;
//     }
//   }
//
//   Future<Map<String, String>?> getRowByDate(String date) async {
//     if (classInfoSheet == null) return null;
//     final row = await classInfoSheet!.values.map.rowByKey(date, fromColumn: 1);
//     if (row != null) {
//       return row;
//     } else {
//       return null;
//     }
//   }
//
//   Future<bool> insertRowByDate(int no, Map<String, String> map) async {
//     if (classInfoSheet == null) return false;
//     final result = await classInfoSheet!.values.map.insertRowByKey(no, map);
//     if (result == false) {
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   Future<bool> insertRow({required Map<String, String> row}) async {
//     if (classInfoSheet == null) return false;
//     final result = await classInfoSheet?.values.map.appendRow(row);
//     if (result == null) return false;
//     return result;
//   }
//
//   Future<Map<String, String>?> getLastData() async {
//     if (classInfoSheet == null) return null;
//     final result = await classInfoSheet?.values.map.lastRow();
//     return result;
//   }
// }
