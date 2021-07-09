import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/stores/user_store.dart';

class UserDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.read<UserStore>();

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
                        title: (userStore.status == Status.AUTHENTICATED
                        && userStore.gUser != null
                        && userStore.gUser!.displayName != null)
                            ? Text(userStore.gUser!.displayName!)
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
                                      Navigator.pop(context);
                                    }),
                                    child: Text("Mit Google anmelden"),
                                  )
                                : ElevatedButton(
                                    onPressed: () async =>
                                        await userStore.signOut().then((_) {
                                      Navigator.pop(context);
                                    }),
                                    child: Text("Abmelden"),
                                  )),
                    Container(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            userStore.status = Status.AUTHENTICATED;
                            Navigator.pop(context);
                          },
                          child: Text("Fakeanmeldung"),
                        )),
                  ]);
            },
          );
        });
  }
}
