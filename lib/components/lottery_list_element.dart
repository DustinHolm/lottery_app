import 'package:flutter/material.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';

import 'lottery_list_trailing.dart';

class LotteryListElement extends StatelessWidget {
  const LotteryListElement({required this.lottery, Key? key}) : super(key: key);
  
  final Lottery lottery;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3.0),
      child: ListTile(
        title: Text(lottery.name),
        trailing: LotteryListTrailing(
            endingDate: lottery.endingDate,
            ticketsUsed: lottery.getTicketsUsed()),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailPage(lottery: lottery))),
      ),
    );
  }
  
}