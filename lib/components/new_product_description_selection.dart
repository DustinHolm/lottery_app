import 'package:flutter/material.dart';

class NewProductDescriptionSelection extends StatelessWidget {
  NewProductDescriptionSelection({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Geben Sie ihrem Produkt eine Beschreibung'),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 7,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
