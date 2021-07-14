import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class LotteryCountdown extends StatelessWidget {
  const LotteryCountdown({required this.endingDate, this.textStyle, Key? key})
      : super(key: key);

  final DateTime endingDate;
  final TextStyle? textStyle;

  int getTimeLeft() {
    if (endingDate.isAfter(DateTime.now())) {
      return endingDate.difference(DateTime.now()).inSeconds;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: getTimeLeft(),
      build: (context, time) {
        Duration duration = Duration(seconds: getTimeLeft());
        int days = duration.inDays;
        int hours = duration.inHours;
        int minutes = duration.inMinutes;
        int seconds = duration.inSeconds;
        if (days > 1) {
          return Text(
            "$days Tage",
            style: textStyle,
            textAlign: TextAlign.center,
          );
        } else if (hours > 1) {
          return Text(
            "$hours h",
            style: textStyle,
            textAlign: TextAlign.center,
          );
        } else if (minutes > 1) {
          return Text(
            "$minutes min",
            style: textStyle,
            textAlign: TextAlign.center,
          );
        } else if (seconds > 0) {
          return Text(
            "$seconds s",
            style: textStyle?.apply(color: Colors.red),
            textAlign: TextAlign.center,
          );
        } else {
          return Text(
            "--",
            style: textStyle,
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
