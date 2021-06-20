import 'package:flutter/material.dart';
import 'package:lottery_app/LotteryGenerator.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/sidebar.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key? key}) : super(key: key);
  final String title = "Übersicht";
  final List<Lottery> lotteries = LotteryGenerator.generateLotteries(100);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: widget.lotteries.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${widget.lotteries[index].product.name}"),
              trailing: Text("${widget.lotteries[index].product.description}"),
            );
          },
        ));
  }
}
