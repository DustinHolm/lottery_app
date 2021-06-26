import 'package:flutter/material.dart';
import 'package:lottery_app/components/check_box_state.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/enums/payment_type.dart';
import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/models/product.dart';
import 'package:lottery_app/models/user.dart';
import 'package:lottery_app/sidebar.dart';
import 'package:lottery_app/stores/lotteries_store.dart';
import 'package:lottery_app/stores/user_store.dart';
import 'package:provider/provider.dart';

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

  //Generate Checkboxes for the Categories
  final categorieList = [
    //dummy data for testing
    CheckBoxState(title: 'Elektroartikel'),
    CheckBoxState(title: 'Küchenzubehör'),
    CheckBoxState(title: 'Haushaltsgeräte'),
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
      ),
      body: SingleChildScrollView(
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
                      Image(
                        image: AssetImage(
                            'assets/placeholder_for_product_image.png'),
                        width: 220,
                        height: 170,
                      ),
                      IconButton(
                        onPressed: () => {
                          //TODO: after pressing the button, open the phones camera and replace the placeholder with the chosen image
                          print('Camera IconButton was pressed')
                        },
                        iconSize: 50.0,
                        icon: Icon(Icons.camera_alt),
                      ),
                      IconButton(
                        onPressed: () => {
                          //TODO: after pressing the button, open the phones folders/gallery and replace the placeholder with the chosen image
                          print('Folder IconButton was pressed')
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
                      //TODO: styling InputDialog, looking more into async functions
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
                          Text('Geben Sie Details über ihr Produkt an'),
                          TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              controller: textFieldControllerProductDetails,
                          ),
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
                                condition: Condition.GOOD,
                                shippingCost: 0),
                            startingDate: DateTime.now(),
                            endingDate: DateTime.now(),
                            ticketsMap: new Map<User, int>(),
                            seller: userStore.user!,
                            winner: null,
                            collectType: CollectType.PACKET,
                            paymentType: PaymentType.CREDIT_CARD
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
