import 'package:flutter/material.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class UserDialog extends StatelessWidget {
  UserDialog({this.buttonText = 'icon', Function? notifyParent, Key? key})
      : notifyParent = notifyParent ?? (() => {}),
        super(key: key);

  final String buttonText;
  final Function notifyParent;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.read<UserStore>();

    SimpleDialog dialogFn(context) => SimpleDialog(
            title: Text(
              "Nutzer",
              style: Theme.of(context).textTheme.headline5,
            ),
            children: [
              ListTile(
                  title: (userStore.status == Status.AUTHENTICATED)
                      ? Text(userStore.name)
                      : const Text("Nicht bei Google angemeldet")),
              if (userStore.status == Status.AUTHENTICATED)
                ListTile(
                  title: Text("${userStore.tickets} Tickets"),
                ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: userStore.status == Status.WAITING
                      ? const CircularProgressIndicator()
                      : userStore.status == Status.UNAUTHENTICATED
                          ? ElevatedButton(
                              onPressed: () async =>
                                  await userStore.signIn().then((_) {
                                notifyParent();
                                Navigator.pop(context);
                              }),
                              child: const Text("Mit Google anmelden"),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                return await userStore.signOut().then((_) {
                                  notifyParent(); //TODO funktioniert nicht
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text("Abmelden"),
                            )),
            ]);

    return buttonText == 'icon'
        ? IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return dialogFn(context);
                },
              );
            })
        : TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return dialogFn(context);
                },
              );
            },
            child: Text(buttonText));
  }
}
