import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/components/filter.dart';
import 'package:lottery_app/components/lottery_list_element.dart';
import 'package:lottery_app/filter/not_ended_filter.dart';
import 'package:lottery_app/filter/not_owned_filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/services/transform_service.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);
  final String title = "Übersicht";

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<ITransform> transformations = [];

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.read<UserStore>();
    List<Lottery> lotteries = context.watch<List<Lottery>>();
    transformations = [...transformations, NotEndedFilter(), NotOwnedFilter(user: userStore.user)];
    lotteries = TransformService.withAll(lotteries, transformations);

    return Scaffold(
      drawer: const Sidebar(),
      appBar: LotteryAppBar(title: widget.title),
      body: Column(children: [
        FilterDropdown(transformations: transformations, handleTransformationsUpdate: (List<ITransform> update) => setState(() => transformations = update)),
        Expanded(
          child: ListView.builder(
            itemCount: lotteries.length,
            itemBuilder: (context, index) {
              Lottery lottery = lotteries[index];
              return LotteryListElement(lottery: lottery);
            },
          ),
        ),
      ]),
    );
  }
}
