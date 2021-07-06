import 'package:flutter/material.dart';

class NewProductNameSelection extends StatelessWidget {
  NewProductNameSelection({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Geben Sie ihrem Produkt einen Name'),
          Container(
            //width: 300.0,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //labelText: 'Produktame',
              ),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}