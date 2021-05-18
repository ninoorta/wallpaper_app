import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'package:wallpaper_app/models/images/images.dart';

class CategoryDetail extends StatelessWidget {
  final List<String> _images = Images().getAllImagesURL();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Nature',
            style: kLabelTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffFAFAFA),
          // backgroundColor: Colors.black,
        ),
        body: GridView.builder(padding: EdgeInsets.symmetric(horizontal: 15.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemCount: _images.length,
            itemBuilder: (BuildContext context, int index) {
              return GridViewItem(imageURL: _images[index]);
            }));
  }
}

class GridViewItem extends StatelessWidget {
  final String imageURL;

  GridViewItem({@required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // margin: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(0, 0, 10.0, 10.0),
      child: GestureDetector(
        onTap: () {
          print('user clicked image in category detail');
          Navigator.pushNamed(context, '/image');
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imageURL,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
