import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottery_app/components/lottery_countdown.dart';
import 'package:lottery_app/enums/lottery_run_type.dart';

class LotteryListTrailing extends StatelessWidget {
  const LotteryListTrailing(
      {required this.endingDate,
      required this.ticketsUsed,
      required this.lotteryRunType,
      Key? key})
      : super(key: key);

  final DateTime endingDate;
  final int ticketsUsed;
  final LotteryRunType lotteryRunType;

  Color getTicketColor() {
    return ticketsUsed <= 0
        ? Colors.grey
        : ticketsUsed <= 23
            ? Colors.yellow
            : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    switch (lotteryRunType) {
      case (LotteryRunType.WIN):
        return const Text(
          "Gewonnen!",
          style: TextStyle(
            color: Colors.green,
          ),
        );
      case (LotteryRunType.NO_WIN):
        return const Text(
          "Leider nicht gewonnen",
          style: TextStyle(
            color: Colors.red,
          ),
        );
      case (LotteryRunType.SOLD):
        return const Text(
          "Verkauft!",
          style: TextStyle(
            color: Colors.green,
          ),
        );
      case (LotteryRunType.NO_SELL):
        return const Text(
          "Leider nicht verkauft",
          style: TextStyle(
            color: Colors.red,
          ),
        );
      default:
        return IntrinsicWidth(
            child: Row(children: [
          Text(
            "$ticketsUsed Tickets",
            style: TextStyle(
              color: getTicketColor(),
            ),
          ),
          const SizedBox(width: 20),
          LotteryCountdown(
            endingDate: endingDate,
            textStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(color: Colors.black),
          ),
        ]));
    }
  }
}
