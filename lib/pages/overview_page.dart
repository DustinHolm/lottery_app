import 'package:flutter/material.dart';
import 'package:lottery_app/LotteryGenerator.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
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
            Lottery lottery = widget.lotteries[index];
            int ticketsUsed = lottery.getTicketsUsed();
            Color color = ticketsUsed <= 0
                ? Colors.grey
                : ticketsUsed <= 23
                    ? Colors.yellow
                    : Colors.red;
            return ListTile(
              title: Text("${lottery.product.name}"),
              trailing: Text(
                "$ticketsUsed Tickets",
                style: TextStyle(
                  color: color,
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(lottery: widget.lotteries[index]))),
            );
          },
        ));
  }
}
