import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ProductDetailBiddingData extends StatelessWidget {
  ProductDetailBiddingData(
      {required this.endingDate, required this.ticketsUsed});

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
    Countdown renderCountdown() {
      return Countdown(
        seconds: getTimeLeft(),
        build: (context, time) {
          Duration duration = Duration(seconds: time.toInt());
          int days = duration.inDays;
          int hours = duration.inHours;
          int minutes = duration.inMinutes;
          int seconds = duration.inSeconds;
          if (days > 1) {
            return Text(
              "$days Tage",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            );
          } else if (hours > 1) {
            return Text(
              "$hours h",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            );
          } else if (minutes > 1) {
            return Text(
              "$minutes min",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            );
          } else if (seconds > 0) {
            return Text(
              "$seconds s",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            );
          } else {
            return Text(
              "--",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            );
          }
        },
      );
    }

    return Container(
        padding: EdgeInsets.all(8),
        height: 80,
        child: Row(
            children: ([
          Expanded(
            child: GridTile(
              child: Text(
                "${ticketsUsed.toString()}",
                style: Theme.of(context).textTheme.headline3,
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
              child: renderCountdown(),
              footer: Text(
                "Verbleibende Zeit",
                style: Theme.of(context).textTheme.overline,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ])));
  }
}
