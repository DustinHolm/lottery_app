import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/condition.dart';

class ConditionIcon extends StatelessWidget {
  const ConditionIcon(this.condition, [Key? key]) : super(key: key);

  static from(Condition condition) {
    return ConditionIcon(condition);
  }

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

    return Tooltip(
        message: tooltip,
        child: Icon(
          icon,
          size: 20,
          color: color,
        ));
  }
}
