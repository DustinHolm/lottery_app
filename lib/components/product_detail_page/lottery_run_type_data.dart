import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/lottery_run_type.dart';
import 'package:lottery_app/models/lottery.dart';

class LotteryRunTypeMessage extends StatelessWidget {
  const LotteryRunTypeMessage(
      {required this.lottery, required this.lotteryRunType, Key? key})
      : super(key: key);

  final Lottery lottery;
  final LotteryRunType lotteryRunType;

  @override
  Widget build(BuildContext context) {
    switch (lotteryRunType) {
      case (LotteryRunType.WIN):
        return Text(
            "Gewonnen!\n"
            "Tretet jetzt in Kontakt: ${lottery.seller.name}", //TODO add email
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.green));
      case (LotteryRunType.NO_WIN):
        return Text("Leider nicht gewonnen",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.red));
      case (LotteryRunType.SOLD):
        return Text(
            "Erfolgreich Verkauft!\n"
            "Tretet jetzt in Kontakt: ${lottery.winner!.name}",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.green));
      case (LotteryRunType.NO_SELL):
        return Text("Leider nicht verkauft",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.red));
      default:
        return const SizedBox();
    }
  }
}
