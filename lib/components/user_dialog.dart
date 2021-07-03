import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/stores/user_store.dart';

class UserDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return IconButton(
        icon: Icon(Icons.account_circle),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(
                  "Nutzer",
                  style: Theme.of(context).textTheme.headline5,
                ),
                children: [
                  ListTile(
                    title: Text("${userStore.user?.name}"),
                  ),
                ],
              );
            },
          );
        });
  }
}
