import 'package:flutter/material.dart';
import 'package:lottery_app/filter/i_transform.dart';

import '../sort_dialog.dart';

class SortButton extends StatelessWidget {
  const SortButton({required this.transformations,
required this.handleTransformationsUpdate,
Key? key})
: super(key: key);

final List<ITransform> transformations;
final Function(List<ITransform>) handleTransformationsUpdate;

@override
Widget build(BuildContext context) {
  return IconButton(
      icon: const Icon(Icons.sort),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => SortDialog(
            transformations: transformations,
            handleTransformationsUpdate: handleTransformationsUpdate,
          ),
        );
      });
}
}
