import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottery_app/components/lottery_countdown.dart';
import 'package:timer_count_down/timer_controller.dart';

class BiddingData extends StatelessWidget {
  BiddingData({required this.endingDate, required this.ticketsUsed, Key? key})
      : super(key: key);

  final DateTime endingDate;
  final int ticketsUsed;
  final CountdownController countdownController =
      CountdownController(autoStart: true);

  int getTimeLeft() {
    if (endingDate.isAfter(DateTime.now())) {
      return endingDate.difference(DateTime.now()).inSeconds;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            child: Row(
                children: ([
              Expanded(
                child: GridTile(
                  child: Text(
                    ticketsUsed.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .apply(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  footer: Text(
                    "Gebote",
                    style: Theme.of(context).textTheme.overline,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: GridTile(
                  child: LotteryCountdown(
                      endingDate: endingDate,
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline3!
                          .apply(color: Colors.black)),
                  footer: Text(
                    "Verbleibende Zeit",
                    style: Theme.of(context).textTheme.overline,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ]))));
  }
}
