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

  static Future<List<String>> getFavoriteIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("favoriteIds") ?? List.empty();
  }

  static Future<bool> addFavoriteId(String favoriteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList("favoriteIds") ?? List.empty();
    return prefs.setStringList("favoriteIds", [...favorites, favoriteId]);
  }

  static Future<bool> removeFavoriteId(String favoriteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList("favoriteIds") ?? List.empty();
    return prefs.setStringList("favoriteIds", favorites.where((id) => id != favoriteId).toList());
  }
}