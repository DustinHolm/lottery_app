import 'package:flutter/material.dart';
import 'package:lottery_app/enums/collect_type.dart';

import '../shipping_icon.dart';

class ShippingData extends StatelessWidget {
  const ShippingData(
      {required this.collectType, required this.shippingCost, Key? key})
      : super(key: key);

  final CollectType collectType;
  final int shippingCost;

  @override
  Widget build(BuildContext context) {
    if (collectType == CollectType.SELF_COLLECT) {
      return GridTile(
        child: ShippingIcon(
          collectType: collectType,
          size: 36,
        ),
        footer: Text(
          collectType.toFormattedString(),
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
            collectType.toFormattedString(),
            style: Theme.of(context).textTheme.overline,
            textAlign: TextAlign.center,
          ),
        ]),
      );
    }
  }
}
