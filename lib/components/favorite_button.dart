import 'package:flutter/material.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/services/local_storage_service.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<StatefulWidget> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: LocalStorageService.getFavoriteIds(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            isFavorited = snapshot.data!.contains(widget.id);
          }

          Icon icon = isFavorited
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);

          return IconButton(
            icon: icon,
            onPressed: () async {
              if (isFavorited) {
                LocalStorageService.removeFavoriteId(widget.id);
                setState(() => isFavorited = false);
              } else {
                LocalStorageService.addFavoriteId(widget.id);
                setState(() => isFavorited = true);
              }
            },
          );
        });
  }
}
