import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/filter.dart';
import 'package:lottery_app/components/overview_page/overview_data.dart';
import 'package:lottery_app/components/user_dialog.dart';
import 'package:lottery_app/filter/not_ended_filter.dart';
import 'package:lottery_app/filter/not_owned_filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
import 'package:lottery_app/services/transform_service.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);
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
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          UserDialog(),
        ],
      ),
      body: Column(children: [
        FilterDropdown(transformations: transformations, handleTransformationsUpdate: (List<ITransform> update) => setState(() => transformations = update)),
        Expanded(
          child: ListView.builder(
            itemCount: lotteries.length,
            itemBuilder: (context, index) {
              Lottery lottery = lotteries[index];
              return Card(
                child: ListTile(
                  title: Text(lottery.name),
                  trailing: OverviewData(
                      endingDate: lottery.endingDate,
                      ticketsUsed: lottery.getTicketsUsed()),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(lottery: lottery))),
                ),
                margin: const EdgeInsets.all(3.0),
              );
            },
          ),
        ),
      ]),
    );
  }
}
