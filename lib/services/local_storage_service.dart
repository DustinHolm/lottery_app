import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<bool> getIsFirstUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isFirstUse") ?? true;
  }

  static Future<bool> setIsFirstUse(bool newState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isFirstUse", newState);
  }
}