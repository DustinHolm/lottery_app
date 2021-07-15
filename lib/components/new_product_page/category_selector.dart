import 'package:flutter/material.dart';
import 'package:lottery_app/components/enum_dropdown_button.dart';
import 'package:lottery_app/enums/category.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector(
      {required this.productCategory,
      required this.handleCategoryUpdate,
      Key? key})
      : super(key: key);

  final Category productCategory;
  final Function(Category) handleCategoryUpdate;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Wählen Sie eine passende Kategorie'),
            EnumDropdownButton<Category>(
              types: Category.values,
              currentValue: productCategory,
              handleValueUpdate: handleCategoryUpdate,
              helperText: "Kategorie",
            )
          ],
        ),
      ),
    );
  }
}
