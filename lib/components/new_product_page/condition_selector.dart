import 'package:flutter/material.dart';
import 'package:lottery_app/components/enum_dropdown_button.dart';
import 'package:lottery_app/enums/condition.dart';

import '../condition_icon.dart';

class ConditionSelector extends StatelessWidget {
  const ConditionSelector(
      {required this.productCondition,
      required this.handleConditionUpdate,
      Key? key})
      : super(key: key);

  final Condition productCondition;
  final Function(Condition) handleConditionUpdate;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Geben Sie den Zustand ihres Produktes an'),
            EnumDropdownButton<Condition>(
              types: Condition.values,
              currentValue: productCondition,
              handleValueUpdate: handleConditionUpdate,
              iconWidget: ConditionIcon.from,
              helperText: "Zustand",
            )
          ],
        ),
      ),
    );
  }
}
