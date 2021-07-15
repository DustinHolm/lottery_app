import 'package:flutter/material.dart';
import 'package:lottery_app/components/app_bar/filter_button.dart';
import 'package:lottery_app/components/app_bar/user_dialog_button.dart';

class LotteryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LotteryAppBar({required this.title, this.actions = const [], this.notifyParent, Key? key}) : super(key: key);

  final String title;
  final List<Widget> actions;
  final Function? notifyParent;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 48,
      title: Row(
        children: [
          SizedBox(child: Image.asset("assets/logo.png"), height: 83),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      actions: [
        ...actions,
        UserDialogButton(notifyParent: notifyParent),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(58);
}
