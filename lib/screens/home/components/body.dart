import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// components
import 'search_bar.dart';
import 'display_image.dart';

// services
import 'package:wallpaper_app/services/categoryService.dart';

class HomeBody extends StatefulWidget {
  List<dynamic> categoryData = [];

  HomeBody({@required this.categoryData});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<dynamic> _categoryData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("data received in body $arguments", wrapWidth: 1024);

    Size size = MediaQuery.of(context).size;
    _categoryData = widget.categoryData;

    return Column(
      children: <Widget>[
        SearchBar(size: size),
        MyCustomCarousel(categoryData: _categoryData),
      ],
    );
  }
}

class MyCustomCarousel extends StatefulWidget {
  List<dynamic> categoryData;

  MyCustomCarousel({this.categoryData});

  @override
  _MyCustomCarouselState createState() => _MyCustomCarouselState();
}

class _MyCustomCarouselState extends State<MyCustomCarousel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Map arguments;
  List<dynamic> _categoryData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _categoryData = widget.categoryData;
    // print("categoryData received from loading screen $_categoryData");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _categoryData.length,
            itemBuilder: (context, index) {
              var currentCategory = _categoryData[index];
              // print("wallpaper $index ${currentCategory["wallpaper"]}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // textBaseline: TextBaseline.alphabetic,
                      children: [
                        AutoSizeText(
                          currentCategory["name"],
                          style: kLabelTextStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 20,
                        ),
                        // Text(currentCategory["name"], style: kLabelTextStyle),
                        TextButton(
                          onPressed: () async {
                            // show loading
                            EasyLoading.instance.radius = 15;
                            // EasyLoading.show(
                            //     status: "Please wait...", dismissOnTap: false);
                            // var imagesData =
                            //     await CategoryService.getChosenCategoryData(
                            //         currentCategory["id"], 1);
                            // // close loading
                            // EasyLoading.dismiss();
                            Navigator.pushNamed(context, "/category",
                                arguments: {
                                  "categoryID": currentCategory["id"],
                                  "pageNumber": 1,
                                  "categoryName": currentCategory["name"],
                                  "data": currentCategory["wallpaper"]
                                });
                          },
                          child: Text(
                            'More',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 15.0),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BuildImagesCarousel(
                    currentCategoryImagesData: _categoryData[index]
                        ["wallpaper"],
                    size: size,
                    currentCategoryID: _categoryData[index]["id"],
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class BuildImagesCarousel extends StatefulWidget {
  const BuildImagesCarousel(
      {Key key,
      @required this.currentCategoryImagesData,
      @required this.size,
      @required this.currentCategoryID})
      : super(key: key);

  final List<dynamic> currentCategoryImagesData;
  final Size size;
  final int currentCategoryID;

  @override
  _BuildImagesCarouselState createState() => _BuildImagesCarouselState();
}

class _BuildImagesCarouselState extends State<BuildImagesCarousel> {
  List _imagesDataInThisCategory;
  bool haveImageData = false;
  ScrollController _scrollController = ScrollController();
  bool first = true;
  int currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("build carousel data received ${widget.currentCategoryImagesData}");
  }

  Map arguments;

  @override
  Widget build(BuildContext context) {
    _imagesDataInThisCategory = widget.currentCategoryImagesData;

    return Container(
        height: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _imagesDataInThisCategory.length,
          itemBuilder: (context, index) {
            return MaterialButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/image', arguments: {
                  "chosenImageData": _imagesDataInThisCategory[index],
                  "imagesInCategory": _imagesDataInThisCategory,
                  "currentIndex": index,
                  "currentCategoryID": widget.currentCategoryID
                });
              },
              padding: EdgeInsets.zero,
              child: Container(
                  // width: 110.0,
                  width: widget.size.width * 0.275,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: DisplayImage(
                      imageURL:
                          "https://mkt.h2c.us/wall/thumb/${_imagesDataInThisCategory[index]["url"]}")),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
