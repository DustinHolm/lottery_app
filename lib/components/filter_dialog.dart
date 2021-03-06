import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/enum_dropdown_button.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/filter/category_filter.dart';
import 'package:lottery_app/filter/collect_type_filter.dart';
import 'package:lottery_app/filter/condition_filter.dart';
import 'package:lottery_app/filter/seller_filter.dart';
import 'package:lottery_app/filter/tickets_less_than_filter.dart';
import 'package:lottery_app/filter/title_filter.dart';
import 'package:lottery_app/filter/i_transform.dart';

import 'condition_icon.dart';

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
  CollectType? collectTypeValue;
  Condition? conditionValue;
  Category? categoryValue;
  TextEditingController valueController = TextEditingController();
  TextEditingController sellerController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  Map<Type, bool> enabledFilters = {
    TitleFilter: false,
    SellerFilter: false,
    TicketsLessThanFilter: false,
    CollectTypeFilter: false,
    ConditionFilter: false,
    CategoryFilter: false,
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
      } else if (transformation.runtimeType == CollectTypeFilter) {
        enabledFilters[CollectTypeFilter] = true;
        collectTypeValue = (transformation as CollectTypeFilter).collectType;
      } else if (transformation.runtimeType == ConditionFilter) {
        enabledFilters[ConditionFilter] = true;
        conditionValue = (transformation as ConditionFilter).condition;
      } else if (transformation.runtimeType == CategoryFilter) {
        enabledFilters[CategoryFilter] = true;
        categoryValue = (transformation as CategoryFilter).category;
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
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Checkbox(
                  value: enabledFilters[TitleFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[TitleFilter] = val ?? false),
                )),
            const Padding(
                padding: EdgeInsets.only(right: 8), child: Text("Name")),
            Expanded(
                child: TextFormField(
              controller: titleController,
              onChanged: (val) =>
                  setState(() => enabledFilters[TitleFilter] = true),
            )),
          ],
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Checkbox(
                  value: enabledFilters[SellerFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[SellerFilter] = val ?? false),
                )),
            const Padding(
                padding: EdgeInsets.only(right: 8), child: Text("Verk??ufer")),
            Expanded(
                child: TextFormField(
              controller: sellerController,
              onChanged: (val) =>
                  setState(() => enabledFilters[SellerFilter] = true),
            ))
          ],
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Checkbox(
                  value: enabledFilters[TicketsLessThanFilter],
                  onChanged: (val) => setState(() =>
                      enabledFilters[TicketsLessThanFilter] = val ?? false),
                )),
            const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text("Weniger Tickets als")),
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: valueController,
              onChanged: (val) =>
                  setState(() => enabledFilters[TicketsLessThanFilter] = true),
            ))
          ],
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Checkbox(
                  value: enabledFilters[CollectTypeFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[CollectTypeFilter] = val ?? false),
                )),
            Expanded(
                child: EnumDropdownButton<CollectType>(
              types: CollectType.values,
              currentValue: collectTypeValue,
              handleValueUpdate: (val) {
                setState(() => collectTypeValue = val);
                setState(() => enabledFilters[CollectTypeFilter] = true);
              },
              helperText: "Versandart",
            ))
          ],
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Checkbox(
                  value: enabledFilters[ConditionFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[ConditionFilter] = val ?? false),
                )),
            Expanded(
                child: EnumDropdownButton<Condition>(
              types: Condition.values,
              currentValue: conditionValue,
              handleValueUpdate: (val) {
                setState(() => conditionValue = val);
                setState(() => enabledFilters[ConditionFilter] = true);
              },
              iconWidget: ConditionIcon.from,
              helperText: "Zustand",
            ))
          ],
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Checkbox(
                  value: enabledFilters[CategoryFilter],
                  onChanged: (val) => setState(
                      () => enabledFilters[CategoryFilter] = val ?? false),
                )),
            Expanded(
                child: EnumDropdownButton<Category>(
              types: Category.values,
              currentValue: categoryValue,
              handleValueUpdate: (val) {
                setState(() => categoryValue = val);
                setState(() => enabledFilters[CategoryFilter] = true);
              },
              helperText: "Kategorie",
            ))
          ],
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
            child: ElevatedButton(
                onPressed: () {
                  for (MapEntry entry in enabledFilters.entries) {
                    if (entry.value == false) continue;

                    if (entry.key == TitleFilter &&
                        titleController.text.trim().isNotEmpty) {
                      nextTransforms.add(TitleFilter(titleController.text));
                    } else if (entry.key == SellerFilter &&
                        sellerController.text.trim().isNotEmpty) {
                      nextTransforms.add(SellerFilter(sellerController.text));
                    } else if (entry.key == TicketsLessThanFilter &&
                        valueController.text.trim().isNotEmpty) {
                      nextTransforms.add(TicketsLessThanFilter(
                          int.tryParse(valueController.text) ?? 0));
                    } else if (entry.key == CollectTypeFilter &&
                        collectTypeValue != null) {
                      nextTransforms.add(CollectTypeFilter(collectTypeValue!));
                    } else if (entry.key == ConditionFilter &&
                        conditionValue != null) {
                      nextTransforms.add(ConditionFilter(conditionValue!));
                    } else if (entry.key == CategoryFilter &&
                        categoryValue != null) {
                      nextTransforms.add(CategoryFilter(categoryValue!));
                    }
                  }
                  widget.handleTransformationsUpdate(nextTransforms);
                  Navigator.pop(context);
                },
                child: const Text("??bernehmen"))),
      ],
    );
  }
}
