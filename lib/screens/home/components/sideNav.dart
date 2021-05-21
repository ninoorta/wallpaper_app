import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'custom_divider.dart';
import 'top_sidenav_content.dart';
import 'footer_copyright.dart';

import 'package:wallpaper_app/models/categories/categories.dart';

import 'package:wallpaper_app/services/categoryService.dart';

class SideNav extends StatefulWidget {
  List<dynamic> categoryData;

  SideNav({this.categoryData});

  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  List<dynamic> _categoryData;

  @override
  Widget build(BuildContext context) {
    _categoryData = widget.categoryData;

    // if(categoryData){
    //   print("have data $categoryData");
    //   test = test.fromJson(categoryData);
    //   print("first ${test[0].icon}");
    // }
    // print("sidenav category data: $categoryData");
    // print("data JSON $categoryDataJSON");

    // print("sideNav ${widget.categoryData}");
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
                                      svgIconLink: _categoryData[index]["icon"],
                                      categoryName: _categoryData[index]
                                          ["name"],
                                      categoryRouteID: _categoryData[index]
                                          ["id"]),
                                 SizedBox(height: 5.0,),
                                ],
                              );
                            } else {
                              return CategoryItem(
                                  svgIconLink: _categoryData[index]["icon"],
                                  categoryName: _categoryData[index]["name"],
                                  categoryRouteID: _categoryData[index]["id"]);
                            }
                          }),
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
  final String svgIconLink;
  final String categoryName;
  final int categoryRouteID;

  CategoryItem(
      {@required this.svgIconLink,
      @required this.categoryName,
      @required this.categoryRouteID});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () async {
          print('click icon category with route: $categoryRouteID');

          var imagesData = await CategoryService.getChosenCategoryData(this.categoryRouteID, 1);
          // get data first

          print("in sideNav $imagesData");
          Navigator.pushNamed(context, "/category", arguments: {
            "categoryID": this.categoryRouteID,
            "pageNumber": 1,
            "categoryName": this.categoryName,
            "data": imagesData
          });
        },
        child: Row(
          children: <Widget>[
            IconButton(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 15.0, 0),
              iconSize: 40,
              icon: SvgPicture.network(
                "https://mkt.h2c.us/wall/icon/$svgIconLink",
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
