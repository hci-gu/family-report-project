import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _collectionNameCode = "familyID";
  static final String _familyMemberUidCode = "familyMemberUID";

  static Future<String> getFamilyCollectionName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_collectionNameCode) ?? "";
  }

  static Future<String> getFamilyMemberUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_familyMemberUidCode) ?? "";
  }

  static Future<bool> setFamilyMemberUid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_familyMemberUidCode, value);
  }

  static Future<bool> setFamilyCollectionName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_collectionNameCode, value);
  }
}
