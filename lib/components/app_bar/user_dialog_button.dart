import 'package:flutter/material.dart';
import 'package:lottery_app/components/user_dialog.dart';

class UserDialogButton extends StatelessWidget {
  UserDialogButton({this.buttonText = 'icon', Function? notifyParent, Key? key})
      : notifyParent = notifyParent ?? (() => {}),
        super(key: key);

  final String buttonText;
  final Function notifyParent;

  @override
  Widget build(BuildContext context) {
    return buttonText == 'icon'
        ? IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => UserDialog(notifyParent: notifyParent),
              );
            })
        : TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => UserDialog(notifyParent: notifyParent),
              );
            },
            child: Text(buttonText));
  }
}
