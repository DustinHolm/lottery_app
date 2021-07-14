import 'package:flutter/material.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/category_filter.dart';
import 'package:lottery_app/filter/collect_type_filter.dart';
import 'package:lottery_app/filter/condition_filter.dart';
import 'package:lottery_app/filter/ending_soonest_sort.dart';
import 'package:lottery_app/filter/least_bids_sort.dart';
import 'package:lottery_app/filter/seller_filter.dart';
import 'package:lottery_app/filter/tickets_less_than_filter.dart';
import 'package:lottery_app/filter/title_filter.dart';
import 'package:lottery_app/filter/i_transform.dart';

import 'number_form_field.dart';

class FilterDropdown extends StatefulWidget {
  const FilterDropdown(
      {required this.transformations,
      required this.handleTransformationsUpdate,
      Key? key})
      : super(key: key);

  final List<ITransform> transformations;
  final Function(List<ITransform>) handleTransformationsUpdate;

  Icon getFilterIcon(Filter filter) {
    switch (filter) {
      case Filter.NO_FILTER:
        return const Icon(Icons.clear);
      case Filter.SELLER_NAME_FILTER:
        return const Icon(Icons.text_fields);
      case Filter.TITLE_FILTER:
        return const Icon(Icons.text_fields);
      case Filter.TICKETS_LESS_THAN_FILTER:
        return const Icon(Icons.text_fields);
      case Filter.CATEGORY_FILTER:
        return const Icon(Icons.arrow_drop_down);
      case Filter.COLLECT_TYPE_FILTER:
        return const Icon(Icons.arrow_drop_down);
      case Filter.CONDITION_FILTER:
        return const Icon(Icons.arrow_drop_down);
      default:
        return const Icon(Icons.sort);
    }
  }

  @override
  _FilterDropdownState createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  Filter? value = Filter.TITLE_FILTER;
  CollectType? collectTypeValue = CollectType.PACKET_INLAND;
  Condition? conditionValue = Condition.LIKE_NEW;
  Category? categoryValue = Category.OTHER;
  TextEditingController valueController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController titleNameValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: DropdownButton<Filter>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.filter_alt),
            iconSize: 24,
            onChanged: (Filter? newValue) {
              setState(() {
                value = newValue;
              });
            },
            items: Filter.values.map<DropdownMenuItem<Filter>>((Filter value) {
              return DropdownMenuItem<Filter>(
                value: value,
                child: Row(children: [
                  widget.getFilterIcon(value),
                  Flexible(
                    child: Text(
                      value.toFormattedString(),
                    ),
                  ),
                  if (widget.transformations
                      .any((t) => t.getEnum() != null && t.getEnum()! == value))
                    const Icon(Icons.check),
                ]),
              );
            }).toList(),
          )),
          Flexible(
              child: value == Filter.TITLE_FILTER
                  ? SizedBox(
                      width: 120,
                      height: 64,
                      child: TextFormField(controller: titleNameValue))
                  : value == Filter.SELLER_NAME_FILTER
                      ? SizedBox(
                          width: 120,
                          height: 64,
                          child:
                              TextFormField(controller: sellerNameController))
                      : value == Filter.TICKETS_LESS_THAN_FILTER
                          ? NumberFormField(
                              controller: valueController, height: 32)
                          : value == Filter.CATEGORY_FILTER
                              ? (DropdownButton<Category>(
                                  value: categoryValue,
                                  isExpanded: true,
                                  onChanged: (Category? newValue) {
                                    setState(() {
                                      categoryValue = newValue;
                                    });
                                  },
                                  items: Category.values
                                      .map<DropdownMenuItem<Category>>(
                                          (Category categoryValue) {
                                    return DropdownMenuItem<Category>(
                                      value: categoryValue,
                                      child: Text(
                                          categoryValue.toFormattedString()),
                                    );
                                  }).toList(),
                                ))
                              : value == Filter.COLLECT_TYPE_FILTER
                                  ? (DropdownButton<CollectType>(
                                      value: collectTypeValue,
                                      isExpanded: true,
                                      onChanged: (CollectType? newValue) {
                                        setState(() {
                                          collectTypeValue = newValue;
                                        });
                                      },
                                      items: CollectType.values
                                          .map<DropdownMenuItem<CollectType>>(
                                              (CollectType collectTypeValue) {
                                        return DropdownMenuItem<CollectType>(
                                          value: collectTypeValue,
                                          child: Text(collectTypeValue
                                              .toFormattedString()),
                                        );
                                      }).toList(),
                                    ))
                                  : value == Filter.CONDITION_FILTER
                                      ? (DropdownButton<Condition>(
                                          value: conditionValue,
                                          onChanged: (Condition? newValue) {
                                            setState(() {
                                              conditionValue = newValue;
                                            });
                                          },
                                          items: Condition.values
                                              .map<DropdownMenuItem<Condition>>(
                                                  (Condition conditionValue) {
                                            return DropdownMenuItem<Condition>(
                                              value: conditionValue,
                                              child: Text(conditionValue
                                                  .toFormattedString()),
                                            );
                                          }).toList(),
                                        ))
                                      : Container()),
          ElevatedButton(
            onPressed: () {
              setState(() {
                switch (value) {
                  case Filter.NO_FILTER:
                    widget.handleTransformationsUpdate([]);
                    break;
                  case Filter.SELLER_NAME_FILTER:
                    var transforms =
                        widget.transformations.where((t) => t is! SellerFilter);
                    widget.handleTransformationsUpdate([
                      ...transforms,
                      SellerFilter(sellerNameController.text)
                    ]);
                    break;
                  case Filter.TITLE_FILTER:
                    var transforms =
                        widget.transformations.where((t) => t is! TitleFilter);
                    widget.handleTransformationsUpdate(
                        [...transforms, TitleFilter(titleNameValue.text)]);
                    break;
                  case Filter.TICKETS_LESS_THAN_FILTER:
                    var v = int.tryParse(valueController.text);
                    if (v != null) {
                      var transforms = widget.transformations
                          .where((t) => t is! TicketsLessThanFilter);
                      widget.handleTransformationsUpdate(
                          [...transforms, TicketsLessThanFilter(v)]);
                    }
                    break;
                  case Filter.CATEGORY_FILTER:
                    if (categoryValue != null) {
                      var transforms = widget.transformations
                          .where((t) => t is! CategoryFilter);
                      widget.handleTransformationsUpdate(
                          [...transforms, CategoryFilter(categoryValue!)]);
                    }
                    break;
                  case Filter.COLLECT_TYPE_FILTER:
                    var transforms = widget.transformations
                        .where((t) => t is! CollectTypeFilter);
                    if (collectTypeValue != null) {
                      widget.handleTransformationsUpdate([
                        ...transforms,
                        CollectTypeFilter(collectTypeValue!)
                      ]);
                    }
                    break;
                  case Filter.CONDITION_FILTER:
                    if (conditionValue != null) {
                      var transforms = widget.transformations
                          .where((t) => t is! ConditionFilter);
                      widget.handleTransformationsUpdate(
                          [...transforms, ConditionFilter(conditionValue!)]);
                    }
                    break;
                  case Filter.ENDING_SOONEST_SORT:
                    widget.handleTransformationsUpdate(
                        [...widget.transformations, EndingSoonestSort()]);
                    break;
                  case Filter.LEAST_BIDS_SORT:
                    widget.handleTransformationsUpdate(
                        [...widget.transformations, LeastBidsSort(asc: true)]);
                    break;
                  default:
                    widget.handleTransformationsUpdate(
                        [...widget.transformations, LeastBidsSort(asc: false)]);
                    break;
                }
              });
            },
            child: const Text('Anwenden'),
          ),
        ],
      ),
    );
  }

  void disposeControllers() {
    valueController.dispose();
    sellerNameController.dispose();
    titleNameValue.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
