import 'package:flutter/material.dart';
import 'package:lottery_app/models/lottery.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({required this.lottery});
  final Lottery lottery;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(lottery.product.name),
          Text(lottery.product.description),
          Text("Zustand: ${lottery.product.condition.toString()}"),
          Text("Versandgebühr: ${lottery.product.shippingCost.toString()}"),
          Text("Verkäufer: ${lottery.seller.name}"),
          Text("Läuft bis: ${lottery.endingDate.toString()}"),
          Text("Anzahl Gebote: ${lottery.ticketsMap.length.toString()}"),
          Text("Versandart: ${lottery.collectType.toString()}"),
        ],
      )
    );
  }

}