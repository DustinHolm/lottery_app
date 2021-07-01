import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/collect_type.dart';

class ShippingDetails extends StatelessWidget {
  ShippingDetails({required this.collectType, this.iconOnly = true});

  CollectType collectType;
  bool iconOnly;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String text;
    switch (collectType) {
      case CollectType.SELF_COLLECT:
        icon = Icons.home;
        text = "Selbstabholung";
        break;
      case CollectType.PACKET:
        icon = Icons.local_shipping;
        text = "Paketlieferung";
        break;
      case CollectType.PACKET_INLAND:
        icon = Icons.local_shipping;
        text = "Paketlieferung (Inland)";
        break;
    }

    if (iconOnly)
      return Icon(icon);
    else
      return Row(children: [
        Icon(icon),
        Text(text),
      ]);
  }
}
