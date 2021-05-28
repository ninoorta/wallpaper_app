import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'package:wallpaper_app/services/categoryService.dart';

// components
import '../../screens/home/components/display_image.dart';

class CategoryDetail extends StatefulWidget {
  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<dynamic> _imagesInCategory;
  ScrollController _scrollController = new ScrollController();
  bool first = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getImagesInThisCategory();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("it's the end");

        EasyLoading.show(status: "Loading...");

        currentPage = currentPage + 1;
        try {
          var newData = await CategoryService.loadMoreCategoryData(
              currentCategoryID, currentPage, 6);

          // print("new data $newData");
          // print("current page $currentPage");

          setState(() {
            _imagesInCategory = _imagesInCategory + newData;
            // print("new images data $_imagesInCategory");
            // print("current length ${_imagesInCategory.length}");
            first = false;
          });
        } catch (err) {
          print("error when loadMoreCategoryData: $err");
          EasyLoading.dismiss();
          EasyLoading.showToast("Please try again");
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void getImagesInThisCategory() async {
    _imagesInCategory = await CategoryService.getChosenCategoryData(
        dataInArguments["categoryID"], dataInArguments["pageNumber"]);
    // print("images data in this category $_imagesInCategory");
  }

  Map dataInArguments = {};
  int currentPage;
  int currentCategoryID;

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();

    dataInArguments = ModalRoute.of(context).settings.arguments;
    currentCategoryID = dataInArguments["categoryID"];
    // debugPrint("in category detail screen $dataInArguments", wrapWidth: 1024);
    if (first) {
      currentPage = dataInArguments["pageNumber"];
      _imagesInCategory = dataInArguments["data"];
    }

    // debugPrint("\n images in category detail screen $_imagesInCategory",
    //     wrapWidth: 1024);
    // print("images length ${_imagesInCategory.length}");

    return Scaffold(
        appBar: AppBar(
          title: Text(
            dataInArguments["categoryName"],
            style: kLabelTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.grey[50],
          // backgroundColor: Colors.black,
        ),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              Navigator.pop(context);
            } else if (details.delta.dx < -sensitivity) {
              //Left Swipe
              // Navigator.pop(context);
            }
          },
          child: GridView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
              ),
              itemCount: _imagesInCategory.length,
              itemBuilder: (BuildContext context, int index) {
                return GridViewItem(
                  imageID: _imagesInCategory[index]["id"],
                  imageURL: _imagesInCategory[index]["url"],
                  imageData: _imagesInCategory[index],
                  imagesInCategory: _imagesInCategory,
                  currentIndex: index,
                  currentCategoryID: currentCategoryID,
                );
              }),
        ));
  }
}

class GridViewItem extends StatelessWidget {
  final String imageURL;
  final int imageID;
  final Map imageData;
  final List imagesInCategory;
  final int currentIndex;
  final int currentCategoryID;

  GridViewItem(
      {this.imageID,
      this.imageURL,
      this.imageData,
      this.imagesInCategory,
      this.currentIndex,
      this.currentCategoryID});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      // margin: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 10.0),
      child: GestureDetector(
        onTap: () {
          print('user clicked image in category detail');
          // EasyLoading.show(maskType: EasyLoadingMaskType.black, dismissOnTap: false, status: "In a second...");
          Navigator.pushNamed(context, '/image', arguments: {
            "chosenImageData": this.imageData,
            "imagesInCategory": imagesInCategory,
            "currentIndex": currentIndex,
            "currentCategoryID": currentCategoryID
          });
          // EasyLoading.dismiss();
        },
        // child: ClipRRect(
        //     borderRadius: BorderRadius.circular(10.0),
        //     child: Image.network(
        //       "https://mkt.h2c.us/wall/thumb/$imageURL",
        //       fit: BoxFit.cover,
        //     )),
        child: DisplayImage(
          imageURL: "https://mkt.h2c.us/wall/thumb/$imageURL",
        ),
      ),
    );
  }
}
