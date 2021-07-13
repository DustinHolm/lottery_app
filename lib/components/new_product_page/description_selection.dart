import 'package:flutter/material.dart';

class DescriptionSelection extends StatelessWidget {
  const DescriptionSelection({required this.controller, Key? key})
      : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Geben Sie ihrem Produkt eine Beschreibung'),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 7,
          controller: controller,
        ),
      ],
    );
  }
}
