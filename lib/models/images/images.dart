import 'package:flutter/cupertino.dart';

class Images {
  static final _imagesList = <ImageModel>[
    // ImageModel('assets/images/image1.jpg'),
    // ImageModel('assets/images/image2.jpg'),
    // ImageModel('assets/images/image3.jpg'),
    // ImageModel('assets/images/image4.jpg'),
    // ImageModel('assets/images/image5.jpg'),
    // ImageModel('assets/images/image6.jpg'),
    // ImageModel('assets/images/image7.jpg'),
    // ImageModel('assets/images/image8.jpg'),
    // ImageModel('assets/images/image9.jpg'),
    // ImageModel('assets/images/image9.jpg'),
    ImageModel('assets/images/images_webp/a22.webp'),
    ImageModel('assets/images/images_webp/among10.webp'),
    ImageModel('assets/images/images_webp/among4416.webp'),
    ImageModel('assets/images/images_webp/anime2314.webp'),
    ImageModel('assets/images/images_webp/girl11.webp'),
    ImageModel('assets/images/images_webp/best5.webp'),
    ImageModel('assets/images/images_webp/cool26.webp'),
    ImageModel('assets/images/images_webp/flower33.webp'),
    ImageModel('assets/images/images_webp/flower42.webp'),
    ImageModel('assets/images/images_webp/game28.webp'),
  ];

  List<String> getAllImagesURL() {
    return Images._imagesList.map((img) => img._urlImage).toList();
  }
}

class ImageModel {
  final String _urlImage;

  ImageModel(@required this._urlImage);
}
