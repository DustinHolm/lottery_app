import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFormField extends StatelessWidget {
  const NumberFormField(
      {required this.controller,
      this.icon,
      this.labelText,
      this.width = 120,
      this.height,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final Icon? icon;
  final String? labelText;
  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: InputDecoration(labelText: labelText, icon: icon)));
  }
}
