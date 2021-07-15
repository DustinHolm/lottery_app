import 'package:flutter/material.dart';
import 'package:lottery_app/components/enum_dropdown_button.dart';
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
                Expanded(
                  child: EnumDropdownButton(
                    types: CollectType.values,
                    currentValue: productCollectType,
                    handleValueUpdate: handleCollectTypeUpdate,
                    helperText: "Versandart",
                  ),
                ),
                if (productCollectType != CollectType.SELF_COLLECT)
                  NumberFormField(controller: controller, width: 80),
                if (productCollectType != CollectType.SELF_COLLECT)
                  const Text("Tickets"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
