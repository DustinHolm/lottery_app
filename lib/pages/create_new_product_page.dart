import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottery_app/components/app_bar.dart';
import 'package:lottery_app/components/new_product_page/category_selector.dart';
import 'package:lottery_app/components/new_product_page/condition_selector.dart';
import 'package:lottery_app/components/new_product_page/description_selection.dart';
import 'package:lottery_app/components/new_product_page/image_selection.dart';
import 'package:lottery_app/components/new_product_page/name_selection.dart';
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
//A Controller to get the TextField Value from Multiline TextFields
//A onSubmit function in a Multiline TextFields does not work
  final textFieldControllerProductName = TextEditingController();
  final textFieldControllerProductDescription = TextEditingController();
  final textFieldControllerProductDetails = TextEditingController();

  Condition productCondition = Condition.OK; //default Condition
  Category productCategory = Category.OTHER; //default Category
  PickedFile? _productImage; //Store Image Path

  @override
  void dispose() {
    // cleans up the controller after use
    textFieldControllerProductName.dispose();
    textFieldControllerProductDescription.dispose();
    textFieldControllerProductDetails.dispose();
    super.dispose();
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
                  productImage: _productImage,
                  handleImageUpdate: (PickedFile? file) =>
                      setState(() => _productImage = file),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        NameSelection(
                            controller: textFieldControllerProductName),
                        DescriptionSelection(
                            controller: textFieldControllerProductDescription),
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
                Center(
                  // Button to send Information further to Backend/ Server
                  child: ElevatedButton(
                    child: const Text('Inserieren'),
                    onPressed: () async {
                      Lottery lottery = Lottery.withRandomId(
                        name: textFieldControllerProductName.text,
                        description: textFieldControllerProductDescription.text,
                        image: null,
                        condition: productCondition,
                        category: productCategory,
                        shippingCost: 0,
                        endingDate: DateTime.now().add(const Duration(minutes: 30)),
                        bidTickets: BidTickets(ticketMap: {}),
                        seller: userStore.user,
                        winner: null,
                        collectType: CollectType.SELF_COLLECT,
                      );
                      LotteryUploadService.upload(lottery, _productImage);
                      Navigator.pushNamed(context, "/seller");
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
