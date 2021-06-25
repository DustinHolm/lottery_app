import 'package:flutter/material.dart';
import 'package:lottery_app/pages/bidder_page.dart';
import 'package:lottery_app/pages/create_new_product_page.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/seller_page.dart';
import 'package:lottery_app/pages/tickets_buy_page.dart';
import 'package:lottery_app/pages/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var firstVisit = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
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
