import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageSelection extends StatelessWidget {
  ImageSelection(
      {required this.productImage, required this.handleImageUpdate, Key? key})
      : super(key: key);
  final PickedFile? productImage;
  final Function(PickedFile?) handleImageUpdate;
  final _picker = ImagePicker(); //Accessing Camera/Folder

  Future _getImageCamera() async {
    PickedFile? image = await _picker.getImage(
        source: ImageSource.camera,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 25);
    if (image == null) {
      handleImageUpdate(null);
    } else {
      handleImageUpdate(image);
    }
  }

  Future _getImageGallery() async {
    PickedFile? image = await _picker.getImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 25);
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
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 160,
                        child: productImage == null
                            ? const Image(
                                image: AssetImage(
                                    'assets/placeholder_for_product_image.png'),
                                height: 160,
                                fit: BoxFit.fitWidth,
                              )
                            : Image.file(
                                File(productImage!.path),
                                height: 160,
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: _getImageCamera,
                      iconSize: 48,
                      icon: const Icon(Icons.camera_alt),
                    ),
                    IconButton(
                      onPressed: _getImageGallery,
                      iconSize: 48,
                      icon: const Icon(Icons.folder),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
