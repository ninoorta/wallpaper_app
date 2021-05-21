import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

import 'package:wallpaper_app/models/images/images.dart';

import 'package:wallpaper_app/services/categoryService.dart';

class CategoryDetail extends StatefulWidget {
  // int categoryID;
  // int pageNumber;
  //
  // CategoryDetail({this.categoryID, this.pageNumber});

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final List<String> _images = Images().getAllImagesURL();

  List<dynamic> _imagesInCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getImagesInThisCategory();
  }

  void getImagesInThisCategory() async {
    _imagesInCategory = await CategoryService.getChosenCategoryData(
        dataInArguments["categoryID"], dataInArguments["pageNumber"]);
    print("images data in this category $_imagesInCategory");
  }

  Map dataInArguments = {};

  @override
  Widget build(BuildContext context) {
    dataInArguments = ModalRoute.of(context).settings.arguments;
    print("in category detail screen $dataInArguments");
    _imagesInCategory = dataInArguments["data"];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            dataInArguments["categoryName"],
            style: kLabelTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffFAFAFA),
          // backgroundColor: Colors.black,
        ),
        body: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
            ),
            itemCount: _imagesInCategory.length,
            itemBuilder: (BuildContext context, int index) {
              return GridViewItem(
                  imageID: _imagesInCategory[index]["id"],
                  imageURL: _imagesInCategory[index]["url"]);
            }));
  }
}

class GridViewItem extends StatelessWidget {
  final String imageURL;
  final int imageID;
  final Map imageData;

  GridViewItem({this.imageID, this.imageURL, this.imageData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // margin: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(0, 0, 10.0, 10.0),
      child: GestureDetector(
        onTap: () async {
          print('user clicked image in category detail');
          Navigator.pushNamed(context, '/image',
              arguments: {
                  "chosenImageData"
              });
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              "https://mkt.h2c.us/wall/thumb/$imageURL",
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
