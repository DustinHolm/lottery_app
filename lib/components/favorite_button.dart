import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Icon icon = (true) // TODO: Favorites not yet implemented
        ? Icon(Icons.favorite_border)
        : Icon(Icons.favorite);

    return IconButton(
      icon: icon,
      onPressed: () => {
        // TODO: Favorites in Users or local Storage?
      },
    );
  }

}