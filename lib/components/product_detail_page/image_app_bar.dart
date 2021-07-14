import 'package:flutter/material.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

import '../app_bar/favorite_button.dart';
import '../app_bar/user_dialog_button.dart';

class ImageAppBar extends StatelessWidget {
  const ImageAppBar({required this.lottery, Key? key}) : super(key: key);

  final Lottery lottery;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    if (lottery.image != null) {
      return SliverAppBar(
        pinned: true,
        expandedHeight: 160,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: NetworkImage(lottery.image!),
                height: 160,
                fit: BoxFit.fitWidth,
              ),
              Container(
                height: 160,
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.6],
                ),
              )),
            ],
          ),
        ),
        actions: [
          UserDialogButton(),
          if (lottery.seller != userStore.user) FavoriteButton(id: lottery.id)
        ],
      );
    } else {
      return SliverAppBar(
        pinned: true,
        actions: [
          UserDialogButton(),
          if (lottery.seller != userStore.user) FavoriteButton(id: lottery.id)
        ],
      );
    }
  }
}
