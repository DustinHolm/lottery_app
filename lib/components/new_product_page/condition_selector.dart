import 'package:flutter/material.dart';
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
            DropdownButton<Condition>(
              value: productCondition,
              hint: const Text('Zustand'),
              items: Condition.values.map((Condition value) {
                return DropdownMenuItem<Condition>(
                  value: value,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                      child: ConditionIcon(condition: value),
                    ),
                    Text(value.toFormattedString()),
                  ]),
                );
              }).toList(),
              onChanged: (newValue) {
                switch (newValue) {
                  case Condition.NEW:
                    handleConditionUpdate(Condition.NEW);
                    break;
                  case Condition.LIKE_NEW:
                    handleConditionUpdate(Condition.LIKE_NEW);
                    break;
                  case Condition.GOOD:
                    handleConditionUpdate(Condition.GOOD);
                    break;
                  case Condition.OK:
                    handleConditionUpdate(Condition.OK);
                    break;
                  case Condition.BAD:
                    handleConditionUpdate(Condition.BAD);
                    break;
                  default:
                    handleConditionUpdate(Condition.OK);
                }
              },
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            )
          ],
        ),
      ),
    );
  }
}
