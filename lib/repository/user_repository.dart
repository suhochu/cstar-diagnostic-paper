import 'package:cstarimage_testpage/constants/google_sheet_info.dart';
import 'package:cstarimage_testpage/repository/google_sheet_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(gSheets: ref.read(googleSheetRepository)),
);

class UserRepository {
  UserRepository({
    required this.gSheets,
  });

  final GSheets gSheets;
  Worksheet? userInfoSheet;

  Future<void> init() async {
    final spreadsheet = await gSheets.spreadsheet(GoogleSheetInfo.spreadsheetId);
    try {
      userInfoSheet = await spreadsheet.addWorksheet(GoogleSheetInfo.userSheet);
    } catch (e) {
      userInfoSheet = spreadsheet.worksheetByTitle(GoogleSheetInfo.userSheet)!;
    }
  }

  Future<Map<String, String>?> isDataExist(String userEmail) async {
    if (userInfoSheet == null) return null;
    final data = await userInfoSheet!.values.map.rowByKey(userEmail, fromColumn: 1);
    if (data != null && data.isNotEmpty) return data;
    return null;
  }

  Future<bool> addRow(Map<String, String> user) async {
    if (userInfoSheet == null) return false;
    final result = await userInfoSheet!.values.map.appendRow(user);
    return result;
  }
}
