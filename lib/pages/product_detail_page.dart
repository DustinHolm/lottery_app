import 'package:flutter/material.dart';
import 'package:lottery_app/components/favorite_button.dart';
import 'package:lottery_app/components/product_detail_page/bidding_data.dart';
import 'package:lottery_app/components/product_detail_page/description_data.dart';
import 'package:lottery_app/components/product_detail_page/seller_data.dart';
import 'package:lottery_app/components/user_dialog.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/stores/user_store.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({required this.lottery});

  final Lottery lottery;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    LotteriesStore lotteriesStore = context.read<LotteriesStore>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                  image: AssetImage("assets/placeholder_for_product_image.png"),
                  height: 160,
                  fit: BoxFit.fitWidth),
            ),
            actions: [
              UserDialog(),
              if (lottery.seller != userStore.appUser) FavoriteButton(id: lottery.id)
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(lottery.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .apply(color: Colors.black)),
                    )),
                BiddingData(
                  endingDate: lottery.endingDate,
                  ticketsUsed: lottery.getTicketsUsed(),
                ),
                SellerData(
                    seller: lottery.seller,
                    collectType: lottery.collectType,
                    shippingCost: lottery.shippingCost),
                DescriptionData(
                    description: lottery.description,
                    condition: lottery.condition),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: lottery.seller == userStore.appUser
          ? null
          : BottomAppBar(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text("Tickets verbleibend: "),
                    Text(
                      "${userStore.tickets}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .apply(color: Colors.red),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: (userStore.status != Status.AUTHENTICATED || userStore.tickets <= 0)
                          ? null
                          : () {
                              lotteriesStore.bidOnLottery(
                                  lottery, userStore.appUser!);
                              userStore.removeTickets(1);
                            },
                      child: Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text("Jetzt bieten!"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
