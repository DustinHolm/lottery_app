import 'package:flutter/material.dart';
import 'package:lottery_app/services/enum_parser.dart';

class EnumDropdownButton<T extends Object> extends StatelessWidget {
  const EnumDropdownButton(
      {required this.types,
      required this.currentValue,
      required this.handleValueUpdate,
      this.iconWidget,
      this.helperText,
      Key? key})
      : super(key: key);

  final List<T> types;
  final T? currentValue;
  final Function(T) handleValueUpdate;
  final Function(T)? iconWidget;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: true,
      value: currentValue,
      hint: (helperText != null) ? Text(helperText!) : null,
      items: types.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Row(children: [
            if (iconWidget != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
                child: iconWidget!(value),
              ),
            Text(EnumParser.parse(value) ?? ""),
          ]),
        );
      }).toList(),
      onChanged: (newValue) =>
          (types.contains(newValue)) ? handleValueUpdate(newValue!) : {},
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
