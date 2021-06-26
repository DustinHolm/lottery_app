import 'package:flutter/material.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class BidderPage extends StatefulWidget {
  BidderPage({Key? key}) : super(key: key);
  final String title = "Offene Gebote";

  @override
  _BidderPageState createState() => _BidderPageState();
}

class _BidderPageState extends State<BidderPage> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    List<Lottery> lotteries = context.select((LotteriesStore store) => store.getBidOnLotteries(userStore.user));

    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: lotteries.length,
        itemBuilder: (context, index) {
          Lottery lottery = lotteries[index];
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
                        ProductDetailPage(lottery: lotteries[index]))),
          );
        },
      ),
    );
  }
}