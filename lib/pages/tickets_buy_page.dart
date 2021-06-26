import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottery_app/sidebar.dart';

class TicketsBuyForm extends StatefulWidget {
  @override
  TicketsBuyFormState createState() {
    return TicketsBuyFormState();
  }
}

Widget numberFormField(TextEditingController controller, Icon icon) =>
    TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(labelText: "Anzahl Tickets", icon: icon));

class TicketsBuyFormState extends State<TicketsBuyForm> {
  var numTicketsController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: Text("Wie viele Tickets willst du kaufen?"),
          ),
          numberFormField(numTicketsController, Icon(Icons.add_shopping_cart)),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 0.0),
            child: ElevatedButton(
              onPressed: () {
                print('buying ${numTicketsController.text} tickets');
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
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.titel),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TicketsBuyForm(),
      ),
    );
  }
}
