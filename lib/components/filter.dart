import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/enums/payment_type.dart';
import 'package:lottery_app/filter/collect_type_filter.dart';
import 'package:lottery_app/filter/condition_filter.dart';
import 'package:lottery_app/filter/ending_soonest_sort.dart';
import 'package:lottery_app/filter/least_bids_sort.dart';
import 'package:lottery_app/filter/payment_type_filter.dart';
import 'package:lottery_app/filter/seller_filter.dart';
import 'package:lottery_app/filter/tickets_less_than_filter.dart';
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
  Filter? value = Filter.NO_FILTER;
  var valueController = new TextEditingController();
  CollectType? collectTypeValue = CollectType.PACKET_INLAND;
  var sellerNameController = new TextEditingController();
  Condition? conditionValue = Condition.NEW;
  PaymentType? paymentTypeValue = PaymentType.BANKWIRE;

  @override
  Widget build(BuildContext context) {
    TransformStore transformStore = context.watch<TransformStore>();

    return Row(
      children: [
        (DropdownButton<Filter>(
          value: value,
          icon: const Icon(Icons.filter_alt),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (Filter? newValue) {
            setState(() {
              value = newValue;
            });
          },
          items: Filter.values.map<DropdownMenuItem<Filter>>((Filter value) {
            return DropdownMenuItem<Filter>(
              value: value,
              child: Text(value.toFormattedString()),
            );
          }).toList(),
        )),
        value == Filter.TICKETS_LESS_THAN_FILTER
            ? numberFormField(valueController, Icon(null), "")
            : value == Filter.COLLECT_TYPE_FILTER
                ? (DropdownButton<CollectType>(
                    value: collectTypeValue,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
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
                        child: Text(collectTypeValue.toFormattedString()),
                      );
                    }).toList(),
                  ))
                : value == Filter.SELLER_NAME_FILTER
                    ? SizedBox(
                        width: 120,
                        child: TextFormField(controller: sellerNameController))
                    : value == Filter.CONDITION_FILTER
                        ? (DropdownButton<Condition>(
                            value: conditionValue,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
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
                                child: Text(conditionValue.toFormattedString()),
                              );
                            }).toList(),
                          ))
                        : value == Filter.PAYMENT_TYPE_FILTER
                            ? (DropdownButton<PaymentType>(
                                value: paymentTypeValue,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (PaymentType? newValue) {
                                  setState(() {
                                    paymentTypeValue = newValue;
                                  });
                                },
                                items: PaymentType.values
                                    .map<DropdownMenuItem<PaymentType>>(
                                        (PaymentType paymentTypeValue) {
                                  return DropdownMenuItem<PaymentType>(
                                    value: paymentTypeValue,
                                    child: Text(
                                        paymentTypeValue.toFormattedString()),
                                  );
                                }).toList(),
                              ))
                            : Container(),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 0.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (value == Filter.NO_FILTER) {
                  transformStore.clear();
                }
                if (value == Filter.TICKETS_LESS_THAN_FILTER) {
                  var v = int.tryParse(valueController.text);
                  if (v != null) {
                    transformStore.add(TicketsLessThanFilter(v));
                  }
                }
                if (value == Filter.COLLECT_TYPE_FILTER) {
                  if (collectTypeValue != null) {
                    transformStore.add(CollectTypeFilter(collectTypeValue!));
                  }
                }
                if (value == Filter.PAYMENT_TYPE_FILTER) {
                  if (paymentTypeValue != null)
                    transformStore.add(PaymentTypeFilter(paymentTypeValue!));
                }
                if (value == Filter.CONDITION_FILTER) {
                  if (conditionValue != null) {
                    transformStore.add(ConditionFilter(conditionValue!));
                  }
                }
                if (value == Filter.SELLER_NAME_FILTER) {
                  transformStore.add(SellerFilter(valueController.text));
                }
                if (value == Filter.LEAST_BIDS_SORT) {
                  transformStore.add(LeastBidsSort());
                }
                if (value == Filter.ENDING_SOONEST_SORT) {
                  transformStore.add(EndingSoonestSort());
                }
              });
              print("Set transforms: ${transformStore.transforms}");
            },
            child: Text('Apply'),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }
}
