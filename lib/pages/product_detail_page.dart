import 'package:flutter/material.dart';
import 'package:lottery_app/components/product_detail_page/bidding_data.dart';
import 'package:lottery_app/components/product_detail_page/description_data.dart';
import 'package:lottery_app/components/product_detail_page/image_app_bar.dart';
import 'package:lottery_app/components/product_detail_page/seller_data.dart';
import 'package:lottery_app/controllers/firestore_controller.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/stores/user_store.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.lottery, Key? key}) : super(key: key);

  final Lottery lottery;

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.watch<UserStore>();

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
                      child: Text(lottery.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .apply(color: Colors.black),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      ),
                    )),
                 /*
                  * TODO: Some kind of "Du hast gewonnen!" or
                  *  "Erfolgreich verkauft" on success. Maybe with a note
                  *  "Tretet jetzt in Kontakt: ${otherUser.email}"
                  */
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
                      "${userStore.tickets}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .apply(color: Colors.red),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: (userStore.status != Status.AUTHENTICATED || userStore.tickets <= 0)
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
