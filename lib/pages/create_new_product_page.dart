import 'package:flutter/material.dart';
import 'package:lottery_app/components/new_product_page/category_selector.dart';
import 'package:lottery_app/components/new_product_page/condition_selector.dart';
import 'package:lottery_app/components/new_product_page/description_selection.dart';
import 'package:lottery_app/components/new_product_page/image_selection.dart';
import 'package:lottery_app/components/new_product_page/name_selection.dart';
import 'package:lottery_app/components/user_dialog.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/models/app_user.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewProductPage extends StatefulWidget {
  CreateNewProductPage({Key? key}) : super(key: key);
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
    LotteriesStore lotteriesStore = context.read<LotteriesStore>();
    UserStore userStore = context.read<UserStore>();

    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          UserDialog(),
        ],
      ),
      body: userStore.status != Status.Authenticated
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
                  margin: EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(8),
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
                CategorySelector(),
                ConditionSelector(
                  productCondition: productCondition,
                  handleConditionUpdate: (Condition condition) =>
                      setState(() => productCondition = condition),
                ),
                Center(
                  child: Container(
                    // Button to send Information further to Backend/ Server
                    child: ElevatedButton(
                      child: Text('Inserieren'),
                      onPressed: () {
                        Lottery lottery = new Lottery.withRandomId(
                          name: textFieldControllerProductName.text,
                          description:
                                  textFieldControllerProductDescription.text,
                          image: null,
                          condition: productCondition,
                          category: Category.OTHER,
                          shippingCost: 0,
                          endingDate: DateTime.now().add(Duration(minutes: 30)),
                          ticketsMap: new Map<AppUser, int>(),
                          seller: userStore.appUser!,
                          winner: null,
                          collectType: CollectType.SELF_COLLECT,
                        );
                        lotteriesStore.addLottery(lottery);
                        Navigator.pushNamed(context, "/seller");
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
