import 'package:flutter/material.dart';
import 'package:lottery_app/filter/i_transform.dart';

import '../filter_dialog.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {required this.transformations,
      required this.handleTransformationsUpdate,
      Key? key})
      : super(key: key);
  final List<ITransform> transformations;
  final Function(List<ITransform>) handleTransformationsUpdate;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.filter_alt),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FilterDialog(
              transformations: transformations,
              handleTransformationsUpdate: handleTransformationsUpdate,
            ),
          );
        });
  }
}
