import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/components/tickets_buy_form.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class TicketsBuyPage extends StatefulWidget {
  const TicketsBuyPage({Key? key}) : super(key: key);
  final String title = 'Tickets kaufen';

  @override
  _TicketsBuyPageState createState() => _TicketsBuyPageState();
}

class _TicketsBuyPageState extends State<TicketsBuyPage> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return Scaffold(
      drawer: const Sidebar(),
      appBar: lotteryAppBar(widget.title),
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
                  const TicketsBuyForm(),
                ],
              )),
    );
  }
}
