import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:lottery_app/stores/transform_store.dart';
import 'package:provider/provider.dart';

import 'number_form.dart';

class FilterDropdown extends StatefulWidget {
  @override
  FilterDropdownState createState() {
    return FilterDropdownState();
  }
}

class FilterDropdownState extends State<FilterDropdown> {
  Filter? value;
  CollectType? collectTypeValue;
  Condition? conditionValue;
  Category? categoryValue;
  var valueController;
  var sellerNameController;
  var titleNameValue;

  FilterDropdownState() {
    value = Filter.TITLE_FILTER;
    collectTypeValue = CollectType.PACKET_INLAND;
    categoryValue = Category.OTHER;
    valueController = new TextEditingController();
    sellerNameController = new TextEditingController();
    titleNameValue = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    TransformStore transformStore = context.watch<TransformStore>();

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
                child: Text(
                  value.toFormattedString(),
                ),
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
                          ? numberFormField(valueController, Icon(null), "",
                              height: 32)
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
                if (value == Filter.NO_FILTER) {
                  transformStore.clear();
                }
                if (value == Filter.SELLER_NAME_FILTER) {
                  transformStore.add(SellerFilter(valueController.text));
                }
                if (value == Filter.TITLE_FILTER) {
                  transformStore.add(TitleFilter(titleNameValue.text));
                }
                if (value == Filter.TICKETS_LESS_THAN_FILTER) {
                  var v = int.tryParse(valueController.text);
                  if (v != null) {
                    transformStore.add(TicketsLessThanFilter(v));
                  }
                }
                if (value == Filter.CATEGORY_FILTER) {
                  if (categoryValue != null) {
                    transformStore.add(CategoryFilter(categoryValue!));
                  }
                }
                if (value == Filter.COLLECT_TYPE_FILTER) {
                  if (collectTypeValue != null) {
                    transformStore.add(CollectTypeFilter(collectTypeValue!));
                  }
                }
                if (value == Filter.CONDITION_FILTER) {
                  if (conditionValue != null) {
                    transformStore.add(ConditionFilter(conditionValue!));
                  }
                }
                if (value == Filter.ENDING_SOONEST_SORT) {
                  transformStore.add(EndingSoonestSort());
                }
                if (value == Filter.LEAST_BIDS_SORT) {
                  transformStore.add(LeastBidsSort(asc: true));
                }
                if (value == Filter.MOST_BIDS_SORT) {
                  transformStore.add(LeastBidsSort(asc: false));
                }
              });
              print("Set transforms: ${transformStore.transforms}");
            },
            child: Text('Anwenden'),
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
