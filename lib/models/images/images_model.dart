import 'package:flutter/cupertino.dart';

class Images {
  static final _imagesList = <ImageModel>[
    ImageModel('assets/images/image1.jpg'),
    ImageModel('assets/images/image2.jpg'),
    ImageModel('assets/images/image3.jpg'),
    ImageModel('assets/images/image4.jpg'),
    ImageModel('assets/images/image5.jpg'),
  ];

  List<String> getAllImages(){
    return Images._imagesList.map((img) => img._urlImage).toList();
  }
}

class ImageModel {
  final String _urlImage;

  ImageModel(@required this._urlImage);
}
