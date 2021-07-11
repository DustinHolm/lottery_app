import 'package:flutter/material.dart';
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
            DropdownButton<Category>(
              value: productCategory,
              hint: const Text('Kategorie'),
              items: Category.values.map((Category value) {
                return DropdownMenuItem<Category>(
                  value: value,
                  child: Row(children: [

                    Text(value.toFormattedString()),
                  ]),
                );
              }).toList(),
              onChanged: (newValue) {
                switch (newValue) {
                  case Category.ELECTRONICS:
                    handleCategoryUpdate(Category.ELECTRONICS);
                    break;
                  case Category.KITCHEN:
                    handleCategoryUpdate(Category.KITCHEN);
                    break;
                  case Category.APPLIANCES:
                    handleCategoryUpdate(Category.APPLIANCES);
                    break;
                  case Category.FURNITURE:
                    handleCategoryUpdate(Category.FURNITURE);
                    break;
                  case Category.DECORATION:
                    handleCategoryUpdate(Category.DECORATION);
                    break;
                  case Category.GARDEN:
                    handleCategoryUpdate(Category.GARDEN);
                    break;
                  case Category.BOOKS:
                    handleCategoryUpdate(Category.BOOKS);
                    break;
                  case Category.CLOTHES:
                    handleCategoryUpdate(Category.CLOTHES);
                    break;
                  case Category.OTHER:
                     handleCategoryUpdate(Category.OTHER);
                     break;
                  default:
                    handleCategoryUpdate(Category.OTHER);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}



