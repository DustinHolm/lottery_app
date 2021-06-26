import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/filter.dart';
import 'package:lottery_app/filter/condition_filter.dart';
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
  var value = Filter.NONE;

  @override
  Widget build(BuildContext context) {
    TransformStore transformStore = context.watch<TransformStore>();

    return (DropdownButton<Filter>(
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
          if (newValue == Filter.TICKETS_LESS_THAN_23) {
            value = Filter.TICKETS_LESS_THAN_23;
            transformStore.add(TicketsLessThanFilter(23));
          } else if (newValue == Filter.CONDITION_NEW) {
            value = Filter.CONDITION_NEW;
            transformStore.add(ConditionFilter(Condition.NEW));
          } else if (newValue == Filter.NONE) {
            value = Filter.NONE;
            transformStore.clear();
          }
        });
        print("Set transforms: ${transformStore.transforms}");
      },
      items: <Filter>[
        Filter.NONE,
        Filter.CONDITION_NEW,
        Filter.TICKETS_LESS_THAN_23,
      ].map<DropdownMenuItem<Filter>>((Filter value) {
        return DropdownMenuItem<Filter>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    ));
  }
}
