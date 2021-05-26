import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import '../../../models/images/images.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// components
import 'search_bar.dart';
import 'display_image.dart';

// services
import 'package:wallpaper_app/services/categoryService.dart';

final List allImagesURL = Images().getAllImagesURL();

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int temp = 0;

  Map arguments = {};
  List<dynamic> categoryData = [];

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    categoryData = arguments["categoryData"];

    // debugPrint("data in body $arguments", wrapWidth: 1024);

    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SearchBar(size: size),
        MyCustomCarousel(categoryData: categoryData),
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

  // void appendData() async {
  //   for (var i = 0; i < widget.categoryData.length; i++) {
  //     var currentCategory = widget.categoryData[i];
  //     var categoryDataInFirstPage =
  //         await CategoryService.getFirstPageCategoryData(currentCategory["id"]);
  //     widget.categoryData[i]["images"] = categoryDataInFirstPage;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.categoryData.length,
            itemBuilder: (context, index) {
              var currentCategory = widget.categoryData[index];
              // var currentCategoryImages = currentCategory["images"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
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
                            EasyLoading.show(
                                status: "Please wait...", dismissOnTap: false);
                            var imagesData =
                                await CategoryService.getChosenCategoryData(
                                    currentCategory["id"], 1);
                            // close loading
                            EasyLoading.dismiss();
                            // print("in home body click see more before passing data to categoryDetail screen $imagesData");

                            Navigator.pushNamed(context, "/category",
                                arguments: {
                                  "categoryID": currentCategory["id"],
                                  "pageNumber": 1,
                                  "categoryName": currentCategory["name"],
                                  "data": imagesData
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
                      currentCategory: currentCategory, size: size),
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
  const BuildImagesCarousel({
    Key key,
    @required this.currentCategory,
    @required this.size,
  }) : super(key: key);

  final currentCategory;
  final Size size;

  @override
  _BuildImagesCarouselState createState() => _BuildImagesCarouselState();
}

class _BuildImagesCarouselState extends State<BuildImagesCarousel> {
  var _imagesData;
  bool haveImageData = false;
  ScrollController _scrollController = ScrollController();
  bool first = true;
  int currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callData();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // print("it's the end ${widget.currentCategory["id"]}");
        // print("it's the end ${widget.currentCategory}");

        EasyLoading.show(status: "Loading...");
        currentPage = currentPage + 1;

        var newData = await CategoryService.loadMoreCategoryData(
            widget.currentCategory["id"], currentPage, 4);

        setState(() {
          _imagesData = _imagesData + newData;
          first = false;
        });
      }
    });
  }

  void callData() async {
    print('start callData ${DateTime.now().second}');
    var thisCategoryImagesDataInFirstPage =
        await CategoryService.getFirstPageCategoryData(
            widget.currentCategory["id"]);
    setState(() {
      _imagesData = thisCategoryImagesDataInFirstPage;
      haveImageData = true;

      print("finish get data: ${DateTime.now().second}");
    });
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();

    if (first) {
      currentPage = 1;
    }

    return Container(
        height: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: haveImageData ? _imagesData.length : 5,
          itemBuilder: (context, index) {
            return MaterialButton(
              onPressed: () async {
                // print("click this image $index");
                // get images in this category
                // var imagesData =
                //     await CategoryService.getChosenCategoryData(
                //     currentCategory["id"], 1);
                print("_imagesData: $_imagesData");
                Navigator.pushNamed(context, '/image', arguments: {
                  "chosenImageData": haveImageData ? _imagesData[index] : null,
                  "imagesInCategory": haveImageData ? _imagesData : null,
                  "currentIndex": haveImageData ? index : null,
                });
              },
              padding: EdgeInsets.zero,
              child: Container(
                // width: 110.0,
                width: widget.size.width * 0.275,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: haveImageData ? Colors.transparent : Colors.black12,
                    borderRadius: BorderRadius.circular(15.0)),
                child: haveImageData
                    ? DisplayImage(
                        imageURL:
                            "https://mkt.h2c.us/wall/thumb/${_imagesData[index]["url"]}")
                    : null,
              ),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
