import 'package:lottery_app/stores/favorites_store.dart';
import 'package:mockito/mockito.dart';

class MockFavoritesStore extends Mock implements FavoritesStore {
  @override
  get favorites => [];
}