import 'package:flutter/material.dart';
import 'package:lottery_app/stores/favorites_store.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<StatefulWidget> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    FavoritesStore favoritesStore = context.watch<FavoritesStore>();
    Icon icon = (favoritesStore.favorites.contains(widget.id))
        ? const Icon(Icons.favorite)
        : const Icon(Icons.favorite_border);

    return IconButton(
      icon: icon,
      onPressed: () {
        if (favoritesStore.favorites.contains(widget.id)) {
          favoritesStore.remove(widget.id);
        } else {
          favoritesStore.add(widget.id);
        }
      },
    );
  }
}
