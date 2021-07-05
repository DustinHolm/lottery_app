import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/pages/bidder_page.dart';
import 'package:lottery_app/pages/create_new_product_page.dart';
import 'package:lottery_app/pages/loading_page.dart';
import 'package:lottery_app/pages/overview_page.dart';
import 'package:lottery_app/pages/seller_page.dart';
import 'package:lottery_app/pages/tickets_buy_page.dart';
import 'package:lottery_app/pages/welcome_page.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/stores/transform_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LotteriesStore()),
      ChangeNotifierProvider(create: (context) => UserStore()),
      ChangeNotifierProvider(create: (context) => TransformStore()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => LoadingPage(),
          '/overview': (context) => OverviewPage(),
          '/bidder': (context) => BidderPage(),
          '/seller': (context) => SellerPage(),
          '/create': (context) => CreateNewProductPage(),
          '/welcome': (context) => WelcomePage(),
          '/tickets': (context) => TicketsBuyPage(),
        });
  }
}
