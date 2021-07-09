import 'package:flutter/material.dart';
import 'package:lottery_app/components/user_dialog.dart';

AppBar lotteryAppBar(String title) => AppBar(
      title: Row(
        children: [
          SizedBox(
              child: Image.asset("assets/logo.png"),
              width: kToolbarHeight,
              height: kToolbarHeight),
          const SizedBox(width: 20),
          Text(title),
        ],
      ),
      actions: [
        UserDialog(),
      ],
    );
