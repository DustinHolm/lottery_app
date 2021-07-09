import 'package:flutter/material.dart';

class NameSelection extends StatelessWidget {
  const NameSelection({required this.controller, Key? key}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Geben Sie ihrem Produkt einen Name'),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
