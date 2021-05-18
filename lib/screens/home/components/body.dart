import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../models/images/images.dart';

// components
import 'search_bar.dart';

final List allImagesURL = Images().getAllImagesURL();

class HomeBody extends StatelessWidget {
  int temp = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SearchBar(size: size),
        MyCustomCarousel(),
      ],
    );
  }
}

class MyCustomCarousel extends StatelessWidget {
  const MyCustomCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('Popular now', style: kLabelTextStyle),
                GestureDetector(
                  onTap: () {
                    print("User click see more");
                  },
                  child: Text(
                    'More',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 200.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: ListView.builder(
                itemCount: allImagesURL.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("click this image $index");
                      Navigator.pushNamed(context, '/category');
                    },
                    child: Container(
                      // width: 110.0,
                      width: size.width * 0.275,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image(
                          image: AssetImage(allImagesURL[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              )),
        ],
      ),
    );
  }
}
