import 'package:flutter/material.dart';
import 'package:lottery_app/sidebar.dart';

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
    );
  }
}
