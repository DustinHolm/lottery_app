import 'package:flutter/material.dart';
import 'package:lottery_app/components/product_detail_bidding_data.dart';
import 'package:lottery_app/components/product_detail_seller_data.dart';
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
              title: Text(lottery.product.name),
              background: Image(
                  image: AssetImage("assets/placeholder_for_product_image.png"),
                  height: 160,
                  fit: BoxFit.fitWidth),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ProductDetailBiddingData(
                  endingDate: lottery.endingDate,
                  ticketsUsed: lottery.getTicketsUsed(),
                ),
                ProductDetailSellerData(
                    seller: lottery.seller,
                    collectType: lottery.collectType,
                    shippingCost: lottery.product.shippingCost),
                Text(lottery.product.description),
                Text("Zustand: ${lottery.product.condition.toString()}"),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userStore.tickets > 0) {
            lotteriesStore.bidOnLottery(lottery, userStore.user!);
            userStore.removeTickets(1);
          }
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }
}
