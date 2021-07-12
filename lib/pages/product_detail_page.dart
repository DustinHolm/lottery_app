import 'package:flutter/material.dart';
import 'package:lottery_app/components/product_detail_page/bidding_data.dart';
import 'package:lottery_app/components/product_detail_page/description_data.dart';
import 'package:lottery_app/components/product_detail_page/image_app_bar.dart';
import 'package:lottery_app/components/product_detail_page/lottery_run_type_data.dart';
import 'package:lottery_app/components/product_detail_page/seller_data.dart';
import 'package:lottery_app/controllers/firestore_controller.dart';
import 'package:lottery_app/enums/lottery_run_type.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.lottery, Key? key}) : super(key: key);

  final Lottery lottery;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();
    final lotteryRunType = getLotteryRunType(lottery, userStore.user);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ImageAppBar(lottery: lottery),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                    margin: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        lottery.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .apply(color: Colors.black),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LotteryRunTypeMessage(
                            lottery: lottery, lotteryRunType: lotteryRunType))),
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
      bottomNavigationBar: lottery.seller == userStore.user
          ? null
          : BottomAppBar(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Text("Tickets verbleibend: "),
                    Text(
                      "${userStore.tickets ?? 0}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .apply(color: Colors.red),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: (userStore.status != Status.AUTHENTICATED ||
                              (userStore.tickets ?? 0) <= 0)
                          ? null
                          : () {
                              lottery.addTicket(userStore.id);
                              userStore.removeTickets(1);
                              FirestoreController.updateLottery(lottery);
                            },
                      child: Row(
                        children: const [
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
