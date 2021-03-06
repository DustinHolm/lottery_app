import 'package:flutter/material.dart';
import 'package:lottery_app/components/lottery_elements/lottery_list_element.dart';
import 'package:lottery_app/filter/bid_on_filter.dart';
import 'package:lottery_app/filter/favorited_filter.dart';
import 'package:lottery_app/filter/i_transform.dart';
import 'package:lottery_app/components/app_bar/lottery_app_bar.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/services/transform_service.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/favorites_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class BidderPage extends StatefulWidget {
  const BidderPage({Key? key}) : super(key: key);
  final String title = "Offene Gebote";

  @override
  _BidderPageState createState() => _BidderPageState();
}

class _BidderPageState extends State<BidderPage> {
  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    FavoritesStore favoriteStore = context.watch<FavoritesStore>();
    List<Lottery> lotteries = context.watch<List<Lottery>>();
    List<ITransform> transformations = [
      BidOnFilter(userId: userStore.id),
      IdFilter(ids: favoriteStore.favorites)
    ];
    lotteries = TransformService.withAny(lotteries, transformations);

    return Scaffold(
      drawer: const Sidebar(),
      appBar: LotteryAppBar(title: widget.title, notifyParent: (() => setState(() {})),),
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
                return LotteryListElement(lottery: lottery);
              },
            ),
    );
  }
}
