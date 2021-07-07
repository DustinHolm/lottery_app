import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/condition_icon.dart';
import 'package:lottery_app/enums/condition.dart';

class DescriptionData extends StatelessWidget {
  DescriptionData({required this.description, required this.condition});

  final String description;
  final Condition condition;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Beschreibung:",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                Text(
                  "Zustand: ",
                  style: Theme.of(context).textTheme.overline,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: ConditionIcon(condition: condition),
                ),
              ],
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}
