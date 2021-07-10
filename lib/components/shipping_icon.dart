import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/collect_type.dart';

class ShippingIcon extends StatelessWidget {
  const ShippingIcon({required this.collectType, this.size = 20, Key? key})
      : super(key: key);

  final CollectType collectType;
  final double size;

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

    return Icon(
      icon,
      size: size,
    );
  }
}
