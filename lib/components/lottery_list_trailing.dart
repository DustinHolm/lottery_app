import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottery_app/components/lottery_countdown.dart';

class LotteryListTrailing extends StatelessWidget {
  const LotteryListTrailing(
      {required this.endingDate,
      required this.ticketsUsed,
      this.showWon,
      this.showSold,
      Key? key})
      : super(key: key);

  final DateTime endingDate;
  final int ticketsUsed;
  final bool? showWon; // TODO: removes other fields, only show "Gewonnen!" or "Leider nicht gewonnen"
  final bool? showSold; // TODO: removes other fields, only show "Verkauft!" or "Leider nicht verkauft"

  Color getTicketColor() {
    return ticketsUsed <= 0
        ? Colors.grey
        : ticketsUsed <= 23
            ? Colors.yellow
            : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
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
        textStyle:
            Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
      ),
    ]));
  }
}
