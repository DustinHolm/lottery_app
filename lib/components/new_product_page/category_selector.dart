import 'package:flutter/material.dart';
import 'package:lottery_app/enums/category.dart';

import '../checkbox_list_element.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Wählen Sie passende Kategorien aus'),
            ...Category.values
                .map((category) => CheckboxListElement(title: category.toFormattedString()))
                .toList(), // '...' is here the 'spread' operator
          ],
        ),
      ),
    );
  }
}
