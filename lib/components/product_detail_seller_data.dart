import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/shipping_icon.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/models/app_user.dart';

class ProductDetailSellerData extends StatelessWidget {
  ProductDetailSellerData(
      {required this.seller,
      required this.collectType,
      required this.shippingCost});

  AppUser seller;
  CollectType collectType;
  int shippingCost;

  String getCollectTypeString() {
    switch (collectType) {
      case CollectType.SELF_COLLECT:
        return "Nur Selbstabholung";
      case CollectType.PACKET:
        return "Lieferung möglich";
      case CollectType.PACKET_INLAND:
        return "Lieferung möglich (Inland)";
    }
  }

  @override
  Widget build(BuildContext context) {
    GridTile renderShipping() {
      if (collectType == CollectType.SELF_COLLECT) {
        return GridTile(
          child: ShippingIcon(
            collectType: collectType,
          ),
          footer: Text(
            getCollectTypeString(),
            style: Theme.of(context).textTheme.overline,
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return GridTile(
          child: Text(
            "$shippingCost Tickets",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          footer: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ShippingIcon(
              collectType: collectType,
            ),
            Text(
              getCollectTypeString(),
              style: Theme.of(context).textTheme.overline,
              textAlign: TextAlign.center,
            ),
          ]),
        );
      }
    }

    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 65,
        child: Row(
          children: [
            Expanded(child: renderShipping()),
            Expanded(
                child: GridTile(
              child: Text(
                "${seller.name}",
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
