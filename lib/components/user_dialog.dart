import 'package:flutter/material.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({this.notifyParent, Key? key}) : super(key: key);

  final Function? notifyParent;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return SimpleDialog(
        title: Text(
          "Nutzer",
          style: Theme.of(context).textTheme.headline5,
        ),
        children: [
          ListTile(
              title: (userStore.status == Status.AUTHENTICATED)
                  ? Text(userStore.name ?? "")
                  : const Text("Nicht bei Google angemeldet")),
          if (userStore.status == Status.AUTHENTICATED)
            ListTile(
              title: Text("${userStore.tickets} Tickets"),
            ),
          Container(
              padding: const EdgeInsets.all(8),
              child: userStore.status == Status.WAITING
                  ? const Center(child: CircularProgressIndicator())
                  : userStore.status == Status.UNAUTHENTICATED
                  ? ElevatedButton(
                onPressed: () async =>
                await userStore.signIn().then((_) {
                  if (notifyParent != null) notifyParent!();
                  Navigator.pop(context);
                }),
                child: const Text("Mit Google anmelden"),
              )
                  : ElevatedButton(
                onPressed: () async {
                  return await userStore.signOut().then((_) {
                    if (notifyParent != null) notifyParent!();
                    Navigator.pop(context);
                  });
                },
                child: const Text("Abmelden"),
              )),
        ]);
  }

}