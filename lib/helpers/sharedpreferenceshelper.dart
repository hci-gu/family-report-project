import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _collectionNameCode = "familyID";

  static Future<String> getFamilyCollectionName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_collectionNameCode) ?? "";
  }

  static Future<bool> setFamilyCollectionName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_collectionNameCode, value);
  }
}
