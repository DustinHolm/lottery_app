import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

import '../components/number_form.dart';

class TicketsBuyForm extends StatefulWidget {
  @override
  TicketsBuyFormState createState() {
    return TicketsBuyFormState();
  }
}

class TicketsBuyFormState extends State<TicketsBuyForm> {
  var numTicketsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: Text("Wie viele Tickets möchtest du kaufen?"),
          ),
          numberFormField(numTicketsController,
              const Icon(Icons.add_shopping_cart), "Anzahl"),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 0.0),
            child: ElevatedButton(
                onPressed: () {
                  var v = int.tryParse(numTicketsController.text);
                  if (v != null) {
                    userStore.addTickets(v);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                            title: Text("Fehlende Eingabe"),
                            content: SingleChildScrollView(
                              child: ListTile(
                                title: Text("Du musst einen Wert eingeben."),
                              ),
                            ));
                      },
                    );
                  }
                },
                child: Text('Kaufen')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    numTicketsController.dispose();
    super.dispose();
  }
}

class TicketsBuyPage extends StatefulWidget {
  const TicketsBuyPage({Key? key}) : super(key: key);
  final String titel = 'Tickets kaufen';

  @override
  _TicketsBuyPageState createState() => _TicketsBuyPageState();
}

class _TicketsBuyPageState extends State<TicketsBuyPage> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return Scaffold(
      drawer: Sidebar(),
      appBar: lotteryAppBar(widget.titel),
      body: userStore.status != Status.AUTHENTICATED
          ? Center(
              child: Text(
              "Diese Funktion ist nur für angemeldete Nutzer verfügbar",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Aktuell ${userStore.tickets} Tickets"),
                  TicketsBuyForm(),
                ],
              )),
    );
  }
}
