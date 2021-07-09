import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/components/filter.dart';
import 'package:lottery_app/components/overview_page/overview_data.dart';
import 'package:lottery_app/lottery_generator.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/stores/transform_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);
  final String title = "Übersicht";

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    LotteriesStore lotteriesStore = context.watch<LotteriesStore>();
    UserStore userStore = context.read<UserStore>();
    List<Lottery> lotteries = context.select((LotteriesStore store) =>
        store.getAvailableLotteries(userStore.appUser));

    TransformStore transformStore = context.watch<TransformStore>();
    lotteries = transformStore.getTransformed(lotteries);

    return Scaffold(
        drawer: Sidebar(),
        appBar: lotteryAppBar(widget.title),
        body: Column(children: [
          FilterDropdown(),
          Expanded(
            child: ListView.builder(
              itemCount: lotteries.length,
              itemBuilder: (context, index) {
                Lottery lottery = lotteries[index];
                return Card(
                  child: ListTile(
                    title: Text("${lottery.name}"),
                    trailing: OverviewData(
                        endingDate: lottery.endingDate,
                        ticketsUsed: lottery.getTicketsUsed()),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(lottery: lottery))),
                  ),
                  margin: EdgeInsets.all(3.0),
                );
              },
            ),
          ),
        ]),
        // TODO: Remove debugging buttons
        floatingActionButton: Wrap(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton(
              heroTag: "addBtn",
              onPressed: () => lotteriesStore.addLotteries(
                  LotteryGenerator.generateLotteries(10, lotteries.length)),
              tooltip: 'Add 10 lotteries',
              child: Icon(Icons.add),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton(
              heroTag: "rmvBtn",
              onPressed: () => lotteriesStore.lotteries = List.empty(),
              tooltip: 'Remove all lotteries',
              child: Icon(Icons.remove),
            ),
          ),
        ]));
  }
}
