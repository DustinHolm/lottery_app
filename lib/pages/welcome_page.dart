import 'package:flutter/material.dart';
import 'package:lottery_app/sidebar.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);
  final String titel = 'Willkommen';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.titel),
      ),
      body: Text(
          "Willkommen, du bist willkommen auf der Willkommensseite unserer tollen Lotterie-App!"),
    );
  }
}
