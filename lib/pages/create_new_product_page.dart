
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottery_app/components/check_box_state.dart';
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

  //String enteredProductName = '';
  //String enteredProductDescription = '';
  //String enteredProductDetails = '';

  @override
  _CreateNewProductPageState createState() => _CreateNewProductPageState();
}

class _CreateNewProductPageState extends State<CreateNewProductPage> {
//A Controller to get the TextField Value from Multiline TextFields
//A onSubmit function in a Multiline TextFields does not work
  final textFieldControllerProductName = TextEditingController();
  final textFieldControllerProductDescription = TextEditingController();
  final textFieldControllerProductDetails = TextEditingController();

  Condition productCondition = Condition.OK; //default

  final _picker = ImagePicker();
  PickedFile _productImage = new PickedFile('assets/placeholder_for_product_image.png');


  //Generate Checkboxes for the Categories
  final categorieList = [
    //dummy data for testing
    CheckBoxState(title: 'Elektroartikel'),
    CheckBoxState(title: 'Küchenzubehör'),
    CheckBoxState(title: 'Haushaltsgeräte'),
    CheckBoxState(title: 'Möbel'),
    CheckBoxState(title: 'Dekoration'),
    CheckBoxState(title: 'Garten'),
    CheckBoxState(title: 'Bücher'),
    CheckBoxState(title: 'Sonstiges'),
  ];

  @override
  void dispose() {
    // cleans up the controller after use
    textFieldControllerProductName.dispose();
    textFieldControllerProductDescription.dispose();
    textFieldControllerProductDetails.dispose();
    super.dispose();
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
    value: checkbox.value,
    title: Text(
      checkbox.title,
    ),
    onChanged: (value) => setState(() => checkbox.value = value!),
  );

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
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Fügen Sie ihrem Produkt ein Bild hinzu'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.horizontal(),
                        child: Image.file(
                          File(_productImage.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      IconButton(
                        onPressed: () async => {
                          //TODO: after pressing the button, open the phones camera and replace the placeholder with the chosen image

                          _productImage = (await _picker.getImage(source: ImageSource.camera))!,
                        },
                        iconSize: 50.0,
                        icon: Icon(Icons.camera_alt),
                      ),
                      IconButton(
                        onPressed: ()  async=> {
                          //TODO: after pressing the button, open the phones folders/gallery and replace the placeholder with the chosen image
                        _productImage = (await _picker.getImage(source: ImageSource.gallery))!,
                        },
                        iconSize: 50.0,
                        icon: Icon(Icons.folder),
                      ),
                    ],
                  ),
                ],
              ),
            ), //For Picture and Picture Select Buttons
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Geben Sie ihrem Produkt einen Name'),
                  Container(
                    //width: 300.0,
                    child: TextField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //labelText: 'Produktame',
                      ),
                      controller: textFieldControllerProductName,

                    ),
                  ),
                ],
              ),
            ), //For the Product Name Text Field

            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Geben Sie ihrem Produkt eine Beschreibung'),
                    Container(
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                          controller: textFieldControllerProductDescription,
                    ),
                    ),
                  ],
                )), //Product Description
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Wählen Sie passende Kategorien aus'),

                    ...categorieList.map(buildSingleCheckbox).toList(),  // '...' is here the 'spread' operator
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
                            items: <String>['Neu', 'Fast wie neu', 'Gut', 'Gebraucht', 'Schlecht'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              switch(_){
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
                              print(productCondition);
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
