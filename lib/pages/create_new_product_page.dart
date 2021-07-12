import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/components/new_product_page/category_selector.dart';
import 'package:lottery_app/components/new_product_page/condition_selector.dart';
import 'package:lottery_app/components/new_product_page/description_selection.dart';
import 'package:lottery_app/components/new_product_page/image_selection.dart';
import 'package:lottery_app/components/new_product_page/name_selection.dart';
import 'package:lottery_app/components/new_product_page/shipping_selector.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/bid_tickets.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/services/lottery_upload_service.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

class CreateNewProductPage extends StatefulWidget {
  const CreateNewProductPage({Key? key}) : super(key: key);
  final String title = 'Angebot erstellen';

  @override
  _CreateNewProductPageState createState() => _CreateNewProductPageState();
}

class _CreateNewProductPageState extends State<CreateNewProductPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final shippingCostController = TextEditingController();
  final durationController = TextEditingController();

  Condition productCondition = Condition.OK; //default Condition
  Category productCategory = Category.OTHER; //default Category
  CollectType productCollectType =
      CollectType.SELF_COLLECT; //default CollectType
  PickedFile? productImage; //Store Image Path

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    shippingCostController.dispose();
    durationController.dispose();
    super.dispose();
  }

  int parseShippingCost(
      CollectType collectType, TextEditingController controller) {
    if (collectType == CollectType.SELF_COLLECT) {
      return 0;
    }
    var cost = int.tryParse(controller.text);
    return cost ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    UserStore userStore = context.read<UserStore>();

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
          : ListView(
              children: [
                ImageSelection(
                  productImage: productImage,
                  handleImageUpdate: (PickedFile? file) =>
                      setState(() => productImage = file),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        NameSelection(controller: nameController),
                        DescriptionSelection(controller: descriptionController),
                      ],
                    ),
                  ),
                ),
                CategorySelector(
                  productCategory: productCategory,
                  handleCategoryUpdate: (Category category) =>
                      setState(() => productCategory = category),
                ),
                ConditionSelector(
                  productCondition: productCondition,
                  handleConditionUpdate: (Condition condition) =>
                      setState(() => productCondition = condition),
                ),
                ShippingSelector(
                  productCollectType: productCollectType,
                  handleCollectTypeUpdate: (CollectType type) =>
                      setState(() => productCollectType = type),
                  controller: shippingCostController,
                ),
                Center(
                  // Button to send Information further to Backend/ Server
                  child: ElevatedButton(
                    child: (nameController.text.trim() != "")
                        ? const Text('Inserieren')
                        : const Text('Name wählen!'),
                    onPressed: (nameController.text.trim() != "")
                        ? () async {
                            Lottery lottery = Lottery.withRandomId(
                              name: nameController.text.trim(),
                              description: descriptionController.text.trim(),
                              image: null,
                              condition: productCondition,
                              category: productCategory,
                              shippingCost: parseShippingCost(
                                  productCollectType, shippingCostController),
                              endingDate:
                                  DateTime.now().add(const Duration(days: 7)),
                              bidTickets: BidTickets(ticketMap: {}),
                              seller: userStore.user,
                              winner: null,
                              collectType: productCollectType,
                            );
                            LotteryUploadService.upload(lottery, productImage);
                            Navigator.pushNamed(context, "/seller");
                          }
                        : null,
                  ),
                ),
              ],
            ),
    );
  }
}
