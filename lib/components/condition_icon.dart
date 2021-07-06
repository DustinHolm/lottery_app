import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/condition.dart';

class ConditionIcon extends StatelessWidget {
  ConditionIcon({
    required this.condition,
  });

  final Condition condition;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    String tooltip = condition.toFormattedString();
    switch (condition) {
      case Condition.NEW:
        icon = Icons.thumb_up_outlined;
        color = Colors.green;
        break;
      case Condition.LIKE_NEW:
        icon = Icons.thumb_up_outlined;
        color = Colors.lightGreen;
        break;
      case Condition.GOOD:
        icon = Icons.thumbs_up_down_outlined;
        color = Colors.yellow;
        break;
      case Condition.OK:
        icon = Icons.thumbs_up_down_outlined;
        color = Colors.orange;
        break;
      case Condition.BAD:
        icon = Icons.thumb_down_outlined;
        color = Colors.red;
        break;
    }

    return Row(
      children: [
        Text("Zustand: ",
        style: Theme.of(context).textTheme.overline,),
        Tooltip(
            message: tooltip,
            child: Icon(
              icon,
              size: 20,
              color: color,
            )),
      ],
    );
  }
}
