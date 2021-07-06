import 'package:flutter/material.dart';
import 'package:lottery_app/components/checkbox_list_element.dart';
import 'package:lottery_app/components/new_product_description_selection.dart';
import 'package:lottery_app/components/new_product_image_selection.dart';
import 'package:lottery_app/components/new_product_name_selection.dart';
import 'package:lottery_app/components/user_dialog.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/models/product.dart';
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

  var currentSelectedValue; //For dropdown Menu

  //Generate Checkboxes for the Categories
  final categorieList = [
    //dummy data for testing
    'Elektroartikel',
    'Küchenzubehör',
    'Haushaltsgeräte',
    'Möbel',
    'Dekoration',
    'Garten',
    'Bücher',
    'Sonstiges',
  ];

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
          )
      )
      : SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[
            NewProductImageSelection(
                productImage: _productImage,
                handleImageUpdate: (PickedFile? file) => setState(() => _productImage = file),
            ),
            NewProductNameSelection(
                controller: textFieldControllerProductName
            ),
            NewProductDescriptionSelection(
                controller: textFieldControllerProductDescription
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Wählen Sie passende Kategorien aus'),

                    ...categorieList.map((title) => CheckboxListElement(title: title)).toList(),  // '...' is here the 'spread' operator
                  ],
                ),
            ), //Select a Product Category

            Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                      margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Geben Sie den Zustand ihres Produktes an'),
                          DropdownButton<String>(
                            value: currentSelectedValue,
                            hint: Text('Zustand'),
                            items: <String>['Neu', 'Fast wie neu', 'Gut', 'Gebraucht', 'Schlecht'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              switch(newValue){
                                case 'Neu': productCondition = Condition.NEW;
                                break;
                                case 'Fast wie neu': productCondition = Condition.LIKE_NEW;
                                break;
                                case 'Gut': productCondition = Condition.GOOD;
                                break;
                                case 'Gebraucht': productCondition = Condition.OK;
                                break;
                                case 'Schlecht': productCondition = Condition.BAD;
                                break;
                                default: productCondition = Condition.OK;
                              }
                              setState(() {
                                currentSelectedValue = newValue;
                              });

                            },

                          )
                          /*TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              controller: textFieldControllerProductDetails,
                          ),*/
                        ],
                      )),
                  Container(
                    // Button to send Information further to Backend/ Server
                    child: TextButton(
                      child: Text('Inserieren'),
                      onPressed: () {
                        Lottery lottery = new Lottery(
                            product: new Product(
                                name: textFieldControllerProductName.text,
                                description: textFieldControllerProductDescription.text,
                                images: new List.empty(),
                                condition: productCondition,
                                shippingCost: 0),
                            startingDate: DateTime.now(),
                            endingDate: DateTime.now(),
                            ticketsMap: new Map<AppUser, int>(),
                            seller: userStore.appUser!,
                            winner: null,
                            collectType: CollectType.PACKET,
                        );
                        lotteriesStore.addLottery(lottery);
                        Navigator.pushNamed(context, "/seller");
                      },
                    ),
                    ),
                ],
              ),
            ), //
          ],
        ),
      ),
    );
  }

}
