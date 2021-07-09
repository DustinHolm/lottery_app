import 'package:flutter/material.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class UserDialog extends StatelessWidget {
  final String buttonText;
  final Function notifyParent;

  UserDialog({this.buttonText = 'icon', Function? notifyParent, Key? key})
      : notifyParent = notifyParent ?? (() => {}),
        super(key: key);

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
                      : Text("Nicht bei Google angemeldet")),
              if (userStore.status == Status.AUTHENTICATED)
                ListTile(
                  title: Text("${userStore.tickets} Tickets"),
                ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: userStore.status == Status.WAITING
                      ? CircularProgressIndicator()
                      : userStore.status == Status.UNAUTHENTICATED
                          ? ElevatedButton(
                              onPressed: () async =>
                                  await userStore.signIn().then((_) {
                                notifyParent();
                                Navigator.pop(context);
                              }),
                              child: Text("Mit Google anmelden"),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                return await userStore.signOut().then((_) {
                                  notifyParent(); //TODO funktioniert nicht
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Abmelden"),
                            )),
              Container(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {
                      userStore.status = Status.AUTHENTICATED;
                      notifyParent();
                      Navigator.pop(context);
                    },
                    child: Text("Fakeanmeldung"),
                  )),
            ]);

    return buttonText == 'icon'
        ? IconButton(
            icon: Icon(Icons.account_circle),
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
