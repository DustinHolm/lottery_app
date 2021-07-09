import 'package:flutter/material.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class SellerPage extends StatefulWidget {
  SellerPage({Key? key}) : super(key: key);
  final String title = "Eigene Angebote";

  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    List<Lottery> lotteries = context.select(
        (LotteriesStore store) => store.getOwnedLotteries(userStore.appUser));

    return Scaffold(
      drawer: Sidebar(),
      appBar: lotteryAppBar(widget.title),
      body: userStore.status != Status.AUTHENTICATED
          ? Center(
              child: Text(
              "Diese Funktion ist nur für angemeldete Nutzer verfügbar",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ))
          : ListView.builder(
              itemCount: lotteries.length,
              itemBuilder: (context, index) {
                Lottery lottery = lotteries[index];
                Text trailing;

                if (lottery.endingDate.isAfter(DateTime.now())) {
                  int ticketsUsed = lottery.getTicketsUsed();
                  Color color = ticketsUsed <= 0
                      ? Colors.grey
                      : ticketsUsed <= 23
                          ? Colors.yellow
                          : Colors.red;
                  trailing = Text("$ticketsUsed Tickets",
                      style: TextStyle(
                        color: color,
                      ));
                } else if (lottery.winner != null) {
                  trailing = Text(
                    "Verkauft!",
                    style: TextStyle(color: Colors.green),
                  );
                } else {
                  trailing = Text(
                    "Nicht verkauft",
                    style: TextStyle(color: Colors.red),
                  );
                }

                return ListTile(
                  title: Text("${lottery.name}"),
                  trailing: trailing,
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
