import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/models/user.dart';

class ProductDetailSellerData extends StatelessWidget {
  ProductDetailSellerData(
      {required this.seller,
      required this.collectType,
      required this.shippingCost});

  User seller;
  CollectType collectType;
  int shippingCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 80,
      child: Row(
        children: [
          Expanded(
              child: GridTile(
            child: Text("Versandgebühr: ${shippingCost.toString()}"),
            footer: Text("Versandart: ${collectType.toString()}"),
          )),
          Expanded(
              child: GridTile(
            child: Text("${seller.name}"),
            footer: Text("Verkäufer"),
          )),
        ],
      ),
    );
  }
}
