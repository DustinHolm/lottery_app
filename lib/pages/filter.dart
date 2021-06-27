import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/payment_type.dart';
import 'package:lottery_app/filter/collect_type_filter.dart';
import 'package:lottery_app/filter/condition_filter.dart';
import 'package:lottery_app/filter/ending_date_filter.dart';
import 'package:lottery_app/filter/ending_soonest_sort.dart';
import 'package:lottery_app/filter/least_bids_sort.dart';
import 'package:lottery_app/filter/payment_type_filter.dart';
import 'package:lottery_app/filter/seller_filter.dart';
import 'package:lottery_app/filter/tickets_less_than_filter.dart';
import 'package:lottery_app/stores/transform_store.dart';
import 'package:provider/provider.dart';

class FilterDropdown extends StatefulWidget {
  @override
  FilterDropdownState createState() {
    return FilterDropdownState();
  }
}

class FilterDropdownState extends State<FilterDropdown> {
  String? value = "No filter";
  var valueController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TransformStore transformStore = context.watch<TransformStore>();

    return Row(
      children: [
        (DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.filter_alt),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              value = newValue;
            });
          },
          items: <String>[
            "No filter",
            "Condition Filter",
            "Collect Type Filter",
            "Ending Date Filter",
            "Payment Type Filter",
            "Seller name Filter",
            "Tickets less than Filter",
            "Least Bids Sort",
            "Ending soonest Sort"
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
        SizedBox(width: 120, child: TextFormField(controller: valueController)),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 0.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (value == "No filter") {
                  transformStore.clear();
                }
                if (value == "Tickets less than filter") {
                  var v = int.tryParse(
                      valueController.text); // TOOD warum FormatException?
                  if (v != null) {
                    transformStore.add(TicketsLessThanFilter(v));
                  }
                }
                if (value == "Collect Type Filter") {
                  transformStore.add(CollectTypeFilter(
                      CollectType.PACKET)); //TODO irgendwie Eingabe
                }
                if (value == "Payment Type Filter") {
                  transformStore.add(PaymentTypeFilter(PaymentType.PAYPAL));
                }
                if (value == "Ending Date Filter") {
                  transformStore.add(EndingDateFilter(DateTime.now()));
                }
                if (value == "Condition Filter") {
                  transformStore.add(ConditionFilter(Condition.NEW));
                }
                if (value == "Tickets less than Filter") {
                  transformStore.add(
                      TicketsLessThanFilter(int.parse(valueController.text)));
                }
                if (value == "Seller name Filter") {
                  transformStore.add(SellerFilter(valueController.text));
                }
                if (value == "Least Bids Sort") {
                  transformStore.add(LeastBidsSort());
                }
                if (value == "Ending soonest Sort") {
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
