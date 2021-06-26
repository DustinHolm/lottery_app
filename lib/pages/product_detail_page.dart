import 'package:flutter/material.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/stores/user_store.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({required this.lottery});
  final Lottery lottery;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    LotteriesStore lotteriesStore = context.read<LotteriesStore>();

    return Scaffold(
        appBar: AppBar(
          title: Text(lottery.product.name),
        ),
        body: ListView(
          children: [
            Text(lottery.product.description),
            Text("Zustand: ${lottery.product.condition.toString()}"),
            Text("Versandgebühr: ${lottery.product.shippingCost.toString()}"),
            Text("Verkäufer: ${lottery.seller.name}"),
            Text("Läuft bis: ${lottery.endingDate.toString()}"),
            Text("Anzahl Gebote: ${lottery.getTicketsUsed().toString()}"),
            Text("Versandart: ${lottery.collectType.toString()}"),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userStore.tickets > 0) {
            lotteriesStore.bidOnLottery(lottery, userStore.user!);
            userStore.removeTickets(1);
          }
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }
}
