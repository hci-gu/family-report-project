import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _collectionNameCode = "familyID";
  static final String _familyMemberUidCode = "familyMemberUID";
  static final String _screenTimeUploadCheckCode = "screenTimeUploadCheck";
  static final String _noOfFamilyMembers = "familyMemberCount";

  static Future<String> getFamilyCollectionName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_collectionNameCode) ?? "";
  }

  static Future<String> getFamilyMemberUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_familyMemberUidCode) ?? "";
  }

  static Future<String> getScreenTimeUploadCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_screenTimeUploadCheckCode) ?? "";
  }

  static Future<bool> setFamilyMemberUid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_familyMemberUidCode, value);
  }

  static Future<bool> setFamilyCollectionName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_collectionNameCode, value);
  }

  static Future<bool> setScreenTimeUploadCheck(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_screenTimeUploadCheckCode, value);
  }
}
