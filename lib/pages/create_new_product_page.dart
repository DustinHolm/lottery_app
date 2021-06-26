import 'package:flutter/material.dart';
import 'package:lottery_app/components/checkBoxState.dart';
import 'package:lottery_app/sidebar.dart';

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
                      onPressed: () => {
                        print('Inserieren Button gedrückt'),
                        print(textFieldControllerProductName.text),
                        print(textFieldControllerProductDescription.text),
                        print(textFieldControllerProductDetails.text),

                        print(categorieList[0].value),
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
