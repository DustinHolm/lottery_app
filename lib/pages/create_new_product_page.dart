import 'package:flutter/material.dart';
import 'package:lottery_app/sidebar.dart';

class CreateNewProductPage extends StatefulWidget {
  CreateNewProductPage ({Key? key}) : super(key: key);
  final String titel = 'Angebot erstellen';

  @override
  _CreateNewProductPageState createState() => _CreateNewProductPageState();


}

class _CreateNewProductPageState extends State<CreateNewProductPage> {
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