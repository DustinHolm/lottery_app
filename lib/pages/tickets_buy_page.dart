import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

import 'number_form.dart';

class TicketsBuyForm extends StatefulWidget {
  @override
  TicketsBuyFormState createState() {
    return TicketsBuyFormState();
  }
}

class TicketsBuyFormState extends State<TicketsBuyForm> {
  var numTicketsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: Text("Wie viele Tickets willst du kaufen?"),
          ),
          numberFormField(numTicketsController, Icon(Icons.add_shopping_cart),
              "Anzahl Tickets"),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 0.0),
            child: ElevatedButton(
              onPressed: () {
                userStore.addTickets(int.parse(numTicketsController.text));
              },
              child: Text('Buy'),
            ),
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
  TicketsBuyPage({Key? key}) : super(key: key);
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
      appBar: AppBar(
        title: Text(widget.titel),
      ),
      body: Padding(
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
