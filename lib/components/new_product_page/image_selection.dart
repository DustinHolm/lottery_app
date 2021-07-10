import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageSelection extends StatelessWidget {
  ImageSelection({required this.productImage, required this.handleImageUpdate, Key? key}) : super(key: key);
  final PickedFile? productImage;
  final Function(PickedFile?) handleImageUpdate;
  final _picker = ImagePicker(); //Accessing Camera/Folder

  Future _getImageCamera() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.camera);
    if (image == null) {
      handleImageUpdate(null);
    } else {
      handleImageUpdate(image);
    }
  }

  Future _getImageGallery() async {
    PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      handleImageUpdate(null);
    } else {
      handleImageUpdate(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Fügen Sie ihrem Produkt ein Bild hinzu'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  //TODO fitting picture in Container, Opening camera
                  decoration: const BoxDecoration(
                  ),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: productImage == null
                        ? const Image(image: AssetImage('assets/placeholder_for_product_image.png'), width: 200, height: 180,fit: BoxFit.scaleDown,)
                        : Image.file(File(productImage!.path), width: 200, height: 180, /*fit: BoxFit.scaleDown,*/),
                  ),
                ),
                IconButton(
                  onPressed: _getImageCamera,
                  iconSize: 50.0,
                  icon: const Icon(Icons.camera_alt),
                ),
                IconButton(
                  onPressed: _getImageGallery,
                  iconSize: 50.0,
                  icon: const Icon(Icons.folder),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}