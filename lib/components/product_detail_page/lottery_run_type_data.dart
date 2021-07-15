import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/controllers/firestore_controller.dart';
import 'package:lottery_app/enums/lottery_run_type.dart';
import 'package:lottery_app/models/app_user.dart';
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
        return FutureBuilder<AppUser?>(
            future: FirestoreController.getUser(lottery.seller.id),
            initialData: lottery.seller,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Text(
                    "Gewonnen!\n"
                    "Tretet jetzt in Kontakt: ${snapshot.data!.email}",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.green));
              } else {
                return Text("Gewonnen!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.green));
              }
            });
      case (LotteryRunType.NO_WIN):
        return Text("Leider nicht gewonnen",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: Colors.red));
      case (LotteryRunType.SOLD):
        return FutureBuilder<AppUser?>(
            future: FirestoreController.getUser(lottery.seller.id),
            initialData: lottery.seller,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Text(
                    "Erfolgreich Verkauft!\n"
                    "Tretet jetzt in Kontakt: ${snapshot.data!.email}",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.green));
              } else {
                return Text("Erfolgreich Verkauft!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.green));
              }
            });
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
