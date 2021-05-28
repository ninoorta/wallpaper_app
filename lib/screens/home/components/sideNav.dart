import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'custom_divider.dart';
import 'top_sidenav_content.dart';
import 'footer_copyright.dart';

import 'package:wallpaper_app/services/categoryService.dart';

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
                      // FutureBuilder(
                      //   future: getCategoryData(),
                      //   builder:
                      //       (BuildContext context, AsyncSnapshot snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return Container(
                      //         height: 400,
                      //         child: Center(
                      //           child: CircularProgressIndicator(),
                      //         ),
                      //       );
                      //     } else {
                      //       if (snapshot.hasError) {
                      //         return Container(
                      //           child: Center(
                      //             child: Text(
                      //               'Error: ${snapshot.error}',
                      //               style: TextStyle(color: Colors.red),
                      //             ),
                      //           ),
                      //         );
                      //       } else {
                      //         return ListView.builder(
                      //             physics: NeverScrollableScrollPhysics(),
                      //             scrollDirection: Axis.vertical,
                      //             shrinkWrap: true,
                      //             itemCount: _categoryData.length,
                      //             itemBuilder: (context, index) {
                      //               if (index == _categoryData.length - 1) {
                      //                 return Column(
                      //                   children: [
                      //                     CategoryItem(
                      //                       iconLink: _categoryData[index]
                      //                           ["thumb"],
                      //                       categoryName: _categoryData[index]
                      //                           ["name"],
                      //                       categoryRouteID:
                      //                           _categoryData[index]["id"],
                      //                     ),
                      //                     SizedBox(
                      //                       height: 5.0,
                      //                     ),
                      //                   ],
                      //                 );
                      //               } else {
                      //                 return CategoryItem(
                      //                     iconLink: _categoryData[index]
                      //                         ["thumb"],
                      //                     categoryName: _categoryData[index]
                      //                         ["name"],
                      //                     categoryRouteID: _categoryData[index]
                      //                         ["id"]);
                      //               }
                      //             });
                      //       }
                      //     }
                      //   },
                      // ),
                      // Container(
                      //     height: 400,
                      //     child: Center(
                      //       child: CircularProgressIndicator(),
                      //     )),
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
              // EasyLoading.show(status: "Moving...", dismissOnTap: false);
              //
              // var data = await CategoryService.getChosenCategoryData(
              //     categoryRouteID, 1);
              //
              // EasyLoading.dismiss();
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
                  width: MediaQuery.of(context).size.width * 0.5,
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
