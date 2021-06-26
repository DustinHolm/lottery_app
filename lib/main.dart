import 'package:flutter/material.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/pages/bidder_page.dart';
import 'package:lottery_app/pages/create_new_product_page.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/seller_page.dart';
import 'package:lottery_app/pages/tickets_buy_page.dart';
import 'package:lottery_app/pages/welcome_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => LotteriesStore(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  var firstVisit = true; // TODO: Move to persistent store

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => this.firstVisit ? WelcomePage() : OverviewPage(),
          '/overview': (context) => OverviewPage(),
          '/bidder': (context) => BidderPage(),
          '/seller': (context) => SellerPage(),
          '/create': (context) => CreateNewProductPage(),
          '/welcome': (context) => WelcomePage(),
          '/tickets': (context) => TicketsBuyPage(),
        });
  }
}
