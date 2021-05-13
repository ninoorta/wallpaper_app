import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/constants.dart';

import 'custom_divider.dart';
import 'top_sidenav_content.dart';

class SideNav extends StatelessWidget {
  const SideNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TopSidenavContent(),
        CustomDivider(),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Wallpapers',
                  style: kSecondaryLabelTextStyle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Category(
                  svgIconLink: "assets/icons/category_icons/new.svg",
                  categoryName: "New",
                  categoryRoute: "new",
                ),
                Category(
                  svgIconLink: "assets/icons/category_icons/4k.svg",
                  categoryName: "Ultra HD",
                  categoryRoute: "ultraHD",
                ),
                Category(
                  svgIconLink: "assets/icons/category_icons/animals.svg",
                  categoryName: "Animals",
                  categoryRoute: "animals",
                ),
                Category(
                  svgIconLink: "assets/icons/category_icons/nature.svg",
                  categoryName: "Nature",
                  categoryRoute: "nature",
                ),
                Category(
                  svgIconLink: "assets/icons/category_icons/sports.svg",
                  categoryName: "Sports",
                  categoryRoute: "sports",
                ),
                Category(
                  svgIconLink: "assets/icons/category_icons/space.svg",
                  categoryName: "Space",
                  categoryRoute: "space",
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 60.0,
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Copyright @2021, All Rights Reserved",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text(
                            "Developed by",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Text(
                            "Gemmob",
                            style: kCopyrightTextStyle,
                          )
                        ],
                      ),
                    ]),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String svgIconLink;
  final String categoryName;
  final String categoryRoute;

  Category(
      {@required this.svgIconLink,
      @required this.categoryName,
      @required this.categoryRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          print('click icon category with route: $categoryRoute');
        },
        child: Row(
          children: <Widget>[
            IconButton(
              icon: SvgPicture.asset(svgIconLink),
            ),
            Text(
              categoryName,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
