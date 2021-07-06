import 'package:flutter/material.dart';
import 'package:lottery_app/enums/condition.dart';

import '../condition_icon.dart';

class ConditionSelector extends StatelessWidget {
  ConditionSelector(
      {required this.productCondition, required this.handleConditionUpdate});

  final Condition productCondition;
  final Function(Condition) handleConditionUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Geben Sie den Zustand ihres Produktes an'),
          DropdownButton<Condition>(
            value: productCondition,
            hint: Text('Zustand'),
            items: Condition.values.map((Condition value) {
              return DropdownMenuItem<Condition>(
                value: value,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                      child: ConditionIcon(condition: value),
                    ),
                    Text(value.toFormattedString()),
                  ]
                ),
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
          )
        ],
      ),
    );
  }
}
