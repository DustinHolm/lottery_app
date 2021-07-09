import 'package:flutter/material.dart';
import 'package:lottery_app/components/overview_page/overview_data.dart';
import 'package:lottery_app/components/user_dialog.dart';
import 'package:lottery_app/filter/owned_filter.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/pages/product_detail_page.dart';
import 'package:lottery_app/services/transform_service.dart';
import 'package:lottery_app/sidebar.dart';
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
    List<Lottery> lotteries = context.watch<List<Lottery>>();
    List<ITransform> transformations = [
      OwnedFilter(user: userStore.user)
    ];
    lotteries = TransformService.withAll(lotteries, transformations);

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
          :  ListView.builder(
        itemCount: lotteries.length,
        itemBuilder: (context, index) {
          Lottery lottery = lotteries[index];
          return Card(
            child: ListTile(
              title: Text(lottery.name),
              trailing: OverviewData(
                  endingDate: lottery.endingDate,
                  ticketsUsed: lottery.getTicketsUsed(),
                  showSold: true),
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
    );
  }
}
