import 'package:flutter/material.dart';
import 'package:lottery_app/components/number_form_field.dart';
import 'package:lottery_app/enums/collect_type.dart';

class ShippingSelector extends StatelessWidget {
  const ShippingSelector(
      {required this.productCollectType,
      required this.handleCollectTypeUpdate,
      required this.controller,
      Key? key})
      : super(key: key);

  final CollectType productCollectType;
  final Function(CollectType) handleCollectTypeUpdate;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Geben Sie die gewünschte Versandart (und -kosten) an'),
            Row(
              children: [
                DropdownButton<CollectType>(
                  value: productCollectType,
                  hint: const Text('Versandart'),
                  items: CollectType.values.map((CollectType value) {
                    return DropdownMenuItem<CollectType>(
                      value: value,
                      child: Row(children: [
                        Text(value.toFormattedString()),
                      ]),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    switch (newValue) {
                      case CollectType.SELF_COLLECT:
                        handleCollectTypeUpdate(CollectType.SELF_COLLECT);
                        break;
                      case CollectType.PACKET:
                        handleCollectTypeUpdate(CollectType.PACKET);
                        break;
                      case CollectType.PACKET_INLAND:
                        handleCollectTypeUpdate(CollectType.PACKET_INLAND);
                        break;
                      default:
                        handleCollectTypeUpdate(CollectType.SELF_COLLECT);
                    }
                  },
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const Spacer(),
                if (productCollectType != CollectType.SELF_COLLECT)
                  NumberFormField(controller: controller, width: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
