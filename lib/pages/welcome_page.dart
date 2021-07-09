import 'package:flutter/material.dart';
import 'package:lottery_app/components/user_dialog.dart';
import 'package:lottery_app/services/local_storage_service.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  final String title = "Lotteriespiel-App";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String text0 =
      "Bevor du auf Produkte bieten kannst musst du dir einen Account anlegen.";
  String text1 = "Wenn du dies jetzt tun willst, klicke auf";
  String text2 = "Möchtest du die App erstmal testen, klicke auf";
  String text3 = "als Gast fortfahren";
  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.read<UserStore>();

    if (userStore.status == Status.AUTHENTICATED) {
      text0 = "Erfolgreich angemeldet.";
      text1 = "Account wechseln";
      text2 = "Klicken zum Fortfahren";
      text3 = "fortfahren";
      signIn = false;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  child: Image.asset("assets/logo.png"),
                  width: 200,
                  height: 200),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Willkommen!",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      "Du hast soeben zum ersten Mal die Lotteriespiel-App geöffnet.",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      text0,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            text1,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        UserDialog(
                            buttonText: signIn ? 'anmelden' : 'wechseln',
                            notifyParent: () => setState(() {})),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            text2,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await LocalStorageService.setIsFirstUse(false);
                              Navigator.popAndPushNamed(context, "/overview");
                            },
                            child: Text(text3))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
