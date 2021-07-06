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
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Wählen Sie passende Kategorien aus'),
            ...categorieList
                .map((title) => CheckboxListElement(title: title))
                .toList(), // '...' is here the 'spread' operator
          ],
        ),
      ),
    );
  }
}
