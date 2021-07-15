import 'package:flutter/material.dart';
import 'package:lottery_app/components/number_form_field.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class TicketsBuyForm extends StatefulWidget {
  const TicketsBuyForm({required this.handleTicketsBought, Key? key}) : super(key: key);

  final Function(int) handleTicketsBought;

  @override
  _TicketsBuyFormState createState() => _TicketsBuyFormState();
}

class _TicketsBuyFormState extends State<TicketsBuyForm> {
  TextEditingController numTicketsController = TextEditingController();

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
          NumberFormField(controller: numTicketsController, icon: const Icon(Icons.add_shopping_cart), labelText: "Anzahl"),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 0.0),
            child: ElevatedButton(
                onPressed: () {
                  var v = int.tryParse(numTicketsController.text);
                  if (v != null) {
                    userStore.addTickets(v);
                    widget.handleTicketsBought(v);
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
                child: const Text('Kaufen')),
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
