import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/filter/seller_filter.dart';
import 'package:lottery_app/filter/tickets_less_than_filter.dart';
import 'package:lottery_app/filter/title_filter.dart';
import 'package:lottery_app/filter/transform.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog(
      {required this.transformations,
      required this.handleTransformationsUpdate,
      Key? key})
      : super(key: key);
  final List<ITransform> transformations;
  final Function(List<ITransform>) handleTransformationsUpdate;

  @override
  State<StatefulWidget> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  CollectType? collectTypeValue = CollectType.PACKET_INLAND;
  Condition? conditionValue = Condition.LIKE_NEW;
  Category? categoryValue = Category.OTHER;
  TextEditingController valueController = TextEditingController();
  TextEditingController sellerController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Map<Type, bool> enabledFilters = {
    TitleFilter: false,
    SellerFilter: false,
    TicketsLessThanFilter: false,
  };
  List<ITransform> nextTransforms = [];

  @override
  initState() {
    int? initialValue;
    String? initialSeller;
    String? initialTitle;
    for (ITransform transformation in widget.transformations) {
      if (transformation.runtimeType == TitleFilter) {
        enabledFilters[TitleFilter] = true;
        initialTitle = (transformation as TitleFilter).title;
      } else if (transformation.runtimeType == SellerFilter) {
        enabledFilters[SellerFilter] = true;
        initialSeller = (transformation as SellerFilter).name;
      } else if (transformation.runtimeType == TicketsLessThanFilter) {
        enabledFilters[TicketsLessThanFilter] = true;
        initialValue = (transformation as TicketsLessThanFilter).n;
      }
    }
    valueController = TextEditingController(
        text: (initialValue != null) ? initialValue.toString() : "");
    sellerController = TextEditingController(text: initialSeller);
    titleController = TextEditingController(text: initialTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      contentPadding: const EdgeInsets.only(right: 12),
      title: const Text("Filter"),
      children: [
        Row(
          children: [
            Expanded(
                flex: 2,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Name"),
                  value: enabledFilters[TitleFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[TitleFilter] = val ?? false),
                )),
            Expanded(
                flex: 1,
                child: TextFormField(
                  controller: titleController,
                )),
          ],
        ),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Verkäufer"),
                  value: enabledFilters[SellerFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[SellerFilter] = val ?? false),
                )),
            Expanded(
                child: TextFormField(
              controller: sellerController,
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Weniger Tickets als"),
                  value: enabledFilters[TicketsLessThanFilter],
                  onChanged: (val) => setState(() =>
                      enabledFilters[TicketsLessThanFilter] = val ?? false),
                )),
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: valueController,
            ))
          ],
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: ElevatedButton(
                onPressed: () {
                  for (MapEntry entry in enabledFilters.entries) {
                    if (entry.value == false) continue;

                    if (entry.key == TitleFilter) {
                      nextTransforms.add(TitleFilter(titleController.text));
                    } else if (entry.key == SellerFilter) {
                      nextTransforms.add(SellerFilter(sellerController.text));
                    } else if (entry.key == TicketsLessThanFilter) {
                      nextTransforms.add(TicketsLessThanFilter(
                          int.tryParse(valueController.text) ?? 0));
                    }
                  }
                  widget.handleTransformationsUpdate(nextTransforms);
                  Navigator.pop(context);
                },
                child: const Text("Übernehmen"))),
      ],
    );
  }
}
