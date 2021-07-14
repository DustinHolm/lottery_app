import 'package:flutter/material.dart';
import 'package:lottery_app/components/lottery_elements/lottery_list_element.dart';
import 'package:lottery_app/filter/owned_filter.dart';
import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/components/app_bar/app_bar.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/services/transform_service.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({Key? key}) : super(key: key);
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
      drawer: const Sidebar(),
      appBar: LotteryAppBar(title: widget.title),
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
          return LotteryListElement(lottery: lottery);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(64, 8, 64, 8),
          child: ElevatedButton(
            child: const Text("Neues Angebot erstellen"),
            onPressed: () {
              Navigator.pushNamed(context, "/create");
            },
          ),
        )
      ),
    );
  }
}
