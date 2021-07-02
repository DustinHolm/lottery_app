import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/collect_type.dart';

class ShippingIcon extends StatelessWidget {
  ShippingIcon({required this.collectType,});

  final CollectType collectType;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (collectType) {
      case CollectType.SELF_COLLECT:
        icon = Icons.home;
        break;
      case CollectType.PACKET:
        icon = Icons.local_shipping;
        break;
      case CollectType.PACKET_INLAND:
        icon = Icons.local_shipping;
        break;
    }

    return Icon(icon);
  }
}
