import 'package:flutter/material.dart';

class DescriptionSelection extends StatelessWidget {
  const DescriptionSelection({required this.controller, Key? key})
      : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Geben Sie ihrem Produkt eine Beschreibung'),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 7,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
