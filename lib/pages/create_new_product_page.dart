import 'package:flutter/material.dart';
import 'package:lottery_app/sidebar.dart';

class CreateNewProductPage extends StatefulWidget {
  CreateNewProductPage({Key? key}) : super(key: key);
  final String title = 'Angebot erstellen';
  String enteredProductName = '';

  @override
  _CreateNewProductPageState createState() => _CreateNewProductPageState();
}

class _CreateNewProductPageState extends State<CreateNewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Geben Sie ihrem Produkt einen Name'),
                Container(
                  //width: 300.0,
                  child: TextField(        //TODO: styling InputDialog, looking more into async functions
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      //labelText: 'Produktame',


                    ),
                    onSubmitted: (String value) => {
                      widget.enteredProductName = value,  //get the text from textfield
                      print(widget.enteredProductName),
                    },
                  ),
                ),
              ],
            ),
          ), //For the Product Name Text Field

          Row(), //For the Product Description
          Row(), //For the Product category
          Row(), //For the Product details and submit button
        ],
      ),
    );
  }
}
