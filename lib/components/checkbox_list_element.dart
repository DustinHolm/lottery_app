import 'package:flutter/material.dart';

class CheckboxListElement extends StatefulWidget {
  const CheckboxListElement(
      {required this.title, this.initial = false, Key? key})
      : super(key: key);
  final String title;
  final bool initial;

  @override
  State<StatefulWidget> createState() => _CheckboxListElementState(initial);
}

class _CheckboxListElementState extends State<CheckboxListElement> {
  _CheckboxListElementState(this.isChecked);

  bool isChecked;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: isChecked,
      title: Text(
        widget.title,
      ),
      onChanged: (value) => setState(() => isChecked = value!),
    );
  }
}
