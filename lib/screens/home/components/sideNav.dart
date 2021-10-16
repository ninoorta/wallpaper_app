import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'custom_divider.dart';
import 'top_sidenav_content.dart';
import 'footer_copyright.dart';

class SideNav extends StatefulWidget {
  List<dynamic> categoryData;

  SideNav({this.categoryData});

  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  List<dynamic> _categoryData;
  bool haveData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryData = widget.categoryData;
  }

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
                  Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _categoryData.length,
                          itemBuilder: (context, index) {
                            if (index == _categoryData.length - 1) {
                              return Column(
                                children: [
                                  CategoryItem(
                                    iconLink: _categoryData[index]["icon"],
                                    categoryName: _categoryData[index]["name"],
                                    categoryRouteID: _categoryData[index]["id"],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              );
                            } else {
                              return CategoryItem(
                                iconLink: _categoryData[index]["icon"],
                                categoryName: _categoryData[index]["name"],
                                categoryRouteID: _categoryData[index]["id"],
                                imagesData: _categoryData[index]["wallpaper"],
                              );
                            }
                          })
                    ],
                  )
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

class CategoryItem extends StatelessWidget {
  final String iconLink;
  final String categoryName;
  final int categoryRouteID;
  final List<dynamic> imagesData;

  CategoryItem(
      {@required this.iconLink,
      @required this.categoryName,
      @required this.categoryRouteID,
      @required this.imagesData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              print("click move to $categoryRouteID \n $imagesData");
              //
              Navigator.popAndPushNamed(context, "/category", arguments: {
                "categoryID": categoryRouteID,
                "pageNumber": 1,
                "categoryName": categoryName,
                "data": imagesData
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    key: UniqueKey(),
                    imageUrl: "https://mkt.h2c.us/wall/icon/$iconLink",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    categoryName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
