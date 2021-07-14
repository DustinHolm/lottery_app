import 'package:flutter/material.dart';
import 'package:lottery_app/components/app_bar/filter_button.dart';
import 'package:lottery_app/components/app_bar/user_dialog_button.dart';

class LotteryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LotteryAppBar({required this.title, this.filterButton, Key? key}) : super(key: key);

  final String title;
  final FilterButton? filterButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SizedBox(child: Image.asset("assets/logo.png"), height: 83),
          const SizedBox(width: 20),
          Text(title),
        ],
      ),
      actions: [
        if (filterButton != null) filterButton!,
        UserDialogButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(58);
}
