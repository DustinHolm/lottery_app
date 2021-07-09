import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/product_detail_page/shipping_data.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/models/app_user.dart';

class SellerData extends StatelessWidget {
  const SellerData(
      {required this.seller,
      required this.collectType,
      required this.shippingCost,
      Key? key}) : super(key: key);

  final AppUser seller;
  final CollectType collectType;
  final int shippingCost;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 65,
        child: Row(
          children: [
            Expanded(child: ShippingData(collectType: collectType, shippingCost: shippingCost,)),
            Expanded(
                child: GridTile(
              child: Text(
                seller.name,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              footer: Text(
                "Verkäufer",
                style: Theme.of(context).textTheme.overline,
                textAlign: TextAlign.center,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
