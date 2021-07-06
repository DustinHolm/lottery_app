import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageSelection extends StatelessWidget {
  ImageSelection({required this.productImage, required this.handleImageUpdate});
  final PickedFile? productImage;
  final Function(PickedFile?) handleImageUpdate;
  final _picker = ImagePicker(); //Accessing Camera/Folder

  Future _getImageCamera() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.camera);
    if (image == null)
      handleImageUpdate(null);
    else
      handleImageUpdate(image);
  }

  Future _getImageGallery() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
    if (image == null)
      handleImageUpdate(null);
    else
      handleImageUpdate(image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Fügen Sie ihrem Produkt ein Bild hinzu'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                //TODO fitting picture in Container, Opening camera
                decoration: BoxDecoration(
                ),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: productImage == null
                      ? Image(image: AssetImage('assets/placeholder_for_product_image.png'), width: 200, height: 180,fit: BoxFit.scaleDown,)
                      : Image.file(File(productImage!.path), width: 200, height: 180, /*fit: BoxFit.scaleDown,*/),
                ),
              ),
              IconButton(
                onPressed: _getImageCamera,
                iconSize: 50.0,
                icon: Icon(Icons.camera_alt),
              ),
              IconButton(
                onPressed: _getImageGallery,
                iconSize: 50.0,
                icon: Icon(Icons.folder),
              ),
            ],
          ),
        ],
      ),
    );
  }

}