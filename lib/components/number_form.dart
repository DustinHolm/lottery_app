import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget numberFormField(
        TextEditingController controller, Icon icon, String labelText) =>
    SizedBox(
        width: 120,
        child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: InputDecoration(labelText: labelText, icon: icon)));
