import 'package:flutter/material.dart';
import 'package:lottery_app/components/user_dialog.dart';

class LotteryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LotteryAppBar({required this.title, Key? key}) : super(key: key);
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SizedBox(
              child: Image.asset("assets/logo.png"),
              width: kToolbarHeight,
              height: kToolbarHeight),
          const SizedBox(width: 20),
          Text(title),
        ],
      ),
      actions: [
        UserDialog(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}