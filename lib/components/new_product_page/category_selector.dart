import 'package:flutter/material.dart';

import '../checkbox_list_element.dart';

class CategorySelector extends StatelessWidget {
  //Generate Checkboxes for the Categories
  final categorieList = [
    //dummy data for testing
    'Elektroartikel',
    'Küchenzubehör',
    'Haushaltsgeräte',
    'Möbel',
    'Dekoration',
    'Garten',
    'Bücher',
    'Sonstiges',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Wählen Sie passende Kategorien aus'),
          ...categorieList
              .map((title) => CheckboxListElement(title: title))
              .toList(), // '...' is here the 'spread' operator
        ],
      ),
    );
  }
}
