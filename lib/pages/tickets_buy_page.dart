import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/app_bar/lottery_app_bar.dart';
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
  int ticketsBought = 0;

  handleTicketsBought(int tickets) {
    setState(() => ticketsBought = tickets);
    Timer(const Duration(seconds: 5), () => setState(() => ticketsBought = 0));
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

    return Scaffold(
      drawer: const Sidebar(),
      appBar: LotteryAppBar(
          title: widget.title, notifyParent: (() => setState(() {}))),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Row(children: [
                      Text(
                        "Aktuell ${userStore.tickets} Tickets",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      if (ticketsBought != 0)
                          Text("  +$ticketsBought gekauft!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .apply(color: Colors.green)),
                    ],)
                  ),

                  TicketsBuyForm(
                      handleTicketsBought: handleTicketsBought),
                ],
              )),
    );
  }
}
