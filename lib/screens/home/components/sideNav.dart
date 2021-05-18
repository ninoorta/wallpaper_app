import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'custom_divider.dart';
import 'top_sidenav_content.dart';
import 'footer_copyright.dart';

class SideNav extends StatelessWidget {
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
            child: SingleChildScrollView(
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
        ),
        FooterCopyright(),
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
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
              iconSize: 40,
              // padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                svgIconLink,
                // width: 40.0,
                // height: 40.0,
              ),
            ),
            Text(
              categoryName,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
