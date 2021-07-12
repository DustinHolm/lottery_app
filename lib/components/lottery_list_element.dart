import 'package:flutter/material.dart';
import 'package:lottery_app/enums/lottery_run_type.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

import 'lottery_list_trailing.dart';

class LotteryListElement extends StatelessWidget {
  const LotteryListElement({required this.lottery, Key? key}) : super(key: key);

  final Lottery lottery;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    final lotteryRunType = getLotteryRunType(lottery, userStore.user);

    return Card(
      margin: const EdgeInsets.all(3.0),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        leading: (lottery.image != null)
            ? Image(
                image: NetworkImage(lottery.image!),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              )
            : null,
        title: Text(
          lottery.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: LotteryListTrailing(
            endingDate: lottery.endingDate,
            ticketsUsed: lottery.getTicketsUsed(),
            lotteryRunType: lotteryRunType),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(lottery: lottery))),
      ),
    );
  }
}
