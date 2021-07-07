import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OverviewData extends StatelessWidget {
  OverviewData({required this.endingDate, required this.ticketsUsed});

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

  Color getTicketColor() {
    return ticketsUsed <= 0
        ? Colors.grey
        : ticketsUsed <= 23
            ? Colors.yellow
            : Colors.red;
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
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.black),
              textAlign: TextAlign.center,
            );
          } else if (hours > 1) {
            return Text(
              "$hours h",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.black),
              textAlign: TextAlign.center,
            );
          } else if (minutes > 1) {
            return Text(
              "$minutes min",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.black),
              textAlign: TextAlign.center,
            );
          } else if (seconds > 0) {
            return Text(
              "$seconds s",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.red),
              textAlign: TextAlign.center,
            );
          } else {
            return Text(
              "--",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .apply(color: Colors.black),
              textAlign: TextAlign.center,
            );
          }
        },
      );
    }

    Text renderTicketsUsed() {
      return Text(
        "$ticketsUsed Tickets",
        style: TextStyle(
          color: getTicketColor(),
        ),
      );
    }

    return IntrinsicWidth(
        child: Row(children: [
      renderTicketsUsed(),
      SizedBox(width: 20),
      renderCountdown()
    ]));
  }
}
