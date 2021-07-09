import 'package:flutter/foundation.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class FavoritesStore extends ChangeNotifier {
  FavoritesStore() {_init();}

  List<String> _favorites = [];

  _init() async {
    _favorites = await LocalStorageService.getFavoriteIds();
  }

  List<String> get favorites => _favorites;

  void add(String favorite) {
    LocalStorageService.addFavoriteId(favorite);
    _favorites.add(favorite);
    notifyListeners();
  }

  void remove(String favorite) {
    LocalStorageService.removeFavoriteId(favorite);
    _favorites.remove(favorite);
    notifyListeners();
  }
}
