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
  String text0 = "";
  String text1 = "";
  String text2 = "";
  String text3 = "";
  String text4 = "";
  String buttonText = "";

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.read<UserStore>();

    if (userStore.status == Status.AUTHENTICATED) {
      text0 = "";
      text1 = "Erfolgreich angemeldet.";
      text2 = "Account";
      text3 = "Klicken zum";
      text4 = "Fortfahren";
      buttonText = "wechseln";
    } else {
      text0 = "Du hast soeben zum ersten Mal die Lotteriespiel-App geöffnet.";
      text1 =
          "Bevor du auf Produkte bieten kannst musst du dir einen Account anlegen.";
      text2 = "Wenn du dies jetzt tun willst, klicke auf";
      text3 = "Möchtest du die App erstmal testen, klicke auf";
      text4 = "als Gast fortfahren";
      buttonText = "anmelden";
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text0,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      text1,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            text2,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        UserDialog(
                            buttonText: buttonText,
                            notifyParent: () => setState(() {}))
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            text3,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await LocalStorageService.setIsFirstUse(false);
                              Navigator.popAndPushNamed(context, "/overview");
                            },
                            child: Text(text4))
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
