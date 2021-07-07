import 'package:flutter/material.dart';
import 'package:lottery_app/enums/category.dart';

import '../checkbox_list_element.dart';

class CategorySelector extends StatelessWidget {
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
            ...Category.values
                .map((category) => CheckboxListElement(title: category.toFormattedString()))
                .toList(), // '...' is here the 'spread' operator
          ],
        ),
      ),
    );
  }
}
