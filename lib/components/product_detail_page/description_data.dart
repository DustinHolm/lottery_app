import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/condition_icon.dart';
import 'package:lottery_app/enums/condition.dart';

class DescriptionData extends StatelessWidget {
  const DescriptionData(
      {required this.description, required this.condition, Key? key})
      : super(key: key);

  final String description;
  final Condition condition;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Beschreibung:",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const Spacer(),
                Text(
                  "Zustand: ",
                  style: Theme.of(context).textTheme.overline,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: ConditionIcon(condition),
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
