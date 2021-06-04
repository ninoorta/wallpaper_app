import 'dart:typed_data';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpaper_app/services/categoryService.dart';
import 'package:wallpaper_app/utilities/constants.dart';

// components
import 'components/dialog_set_wallpaper.dart';
import 'components/dialog_set_ios.dart';
import 'components/dialog_info.dart';
import 'package:image_save/image_save.dart';

// test
import 'dart:async';
import 'dart:io';

// top snackBar
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

bool isDarkMode = false;

class ImageDetail extends StatefulWidget {
  @override
  _ImageDetailState createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  Map arguments = {};
  Map imageData = {};
  List<dynamic> imagesInCategory;
  int initialImageID;
  int initialImageIndex;
  int currentPage;
  int currentCategoryID;
  bool first = true;

  List<Widget> renderAllImagesWidget(List<dynamic> imagesData, size) {
    List<Widget> listImagesWidgets = [];

    for (Map imageData in imagesData) {
      var newWidget = BuildImageDetail(size: size, imageData: imageData);

      listImagesWidgets.add(newWidget);
    }

    return listImagesWidgets;
  }

  void loadMoreData() async {
    // EasyLoading.show(status: "Loading...");

    currentPage = currentPage + 1;
    try {
      var newData = await CategoryService.loadMoreCategoryData(
          currentCategoryID, currentPage, 5);
      // EasyLoading.dismiss();
      setState(() {
        imagesInCategory = imagesInCategory + newData;
        first = false;
      });
    } catch (err) {
      print("error when loadMoreCategoryData: $err");
      EasyLoading.dismiss();
      EasyLoading.showToast("Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (first) {
      arguments = ModalRoute.of(context).settings.arguments;

      print("arguments in imageDetail screen $arguments");
      imageData = arguments["chosenImageData"];
      imagesInCategory = arguments["imagesInCategory"];
      initialImageID = imageData["id"];
      initialImageIndex = arguments["currentIndex"];
      currentPage = arguments["currentPage"];
      currentCategoryID = arguments["currentCategoryID"];

      print("chosen image data $imageData");

      first = false;
    }

    final PageController _controller = PageController(
        initialPage: initialImageIndex, keepPage: true, viewportFraction: 1);

    return SafeArea(
      child: Scaffold(
          body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          print("changed to $index");
          if (index == imagesInCategory.length - 2) {
            print("last");
            loadMoreData();
          } else if (index == 0) {
            print("oh first one");
          }
        },
        children: renderAllImagesWidget(imagesInCategory, size),
      )),
    );
  }
}

class BuildImageDetail extends StatefulWidget {
  const BuildImageDetail({
    Key key,
    @required this.size,
    @required this.imageData,
  }) : super(key: key);

  final Size size;
  final Map imageData;

  @override
  _BuildImageDetailState createState() => _BuildImageDetailState();
}

class _BuildImageDetailState extends State<BuildImageDetail> {
  @override
  Widget build(BuildContext context) {
    // print("device width ${size.width}");
    // print("device height ${size.height}");
    return Stack(
      children: <Widget>[
        Container(
          height: widget.size.height,
          width: widget.size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              // valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // default
            ),
          ),
        ),
        Container(
          width: widget.size.width,
          height: widget.size.height,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: "https://mkt.h2c.us/wall/photo/${widget.imageData["url"]}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: widget.size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // container for back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.transparent),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        color: isDarkMode ? Colors.black : Colors.white,
                        iconSize: 35,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Container(
                    // width: size.width,
                    // margin: EdgeInsets.all(15.0),
                    margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.black.withOpacity(0.5)),
                      child: IconButton(
                        iconSize: 30,
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        onPressed: () {
                          //  change mode now
                          setState(() {
                            isDarkMode = !isDarkMode;
                            print("darkmode? $isDarkMode");
                          });
                        },
                        icon: Icon(isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageDetailButton(
                    iconURL: Icons.info_outline_rounded,
                    iconText: "Info",
                    actionIndex: 0,
                    imgData: widget.imageData,
                  ),
                  ImageDetailButton(
                      iconURL: Icons.save_alt_rounded,
                      iconText: "Save",
                      actionIndex: 1,
                      imgURL:
                          "https://mkt.h2c.us/wall/photo/${widget.imageData["url"]}"),
                  ImageDetailButton(
                      iconURL: Icons.brush_rounded,
                      iconText: "Apply",
                      actionIndex: 2,
                      imgURL:
                          "https://mkt.h2c.us/wall/photo/${widget.imageData["url"]}"),
                  // ImageDetailButton( later feature
                  //   iconURL: Icons.favorite_border_rounded,
                  //   iconText: "Favorite",
                  //   actionIndex: 3,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageDetailButton extends StatefulWidget {
  IconData iconURL;
  final String iconText;
  final int actionIndex;
  final String imgURL;
  final imgData;

  ImageDetailButton(
      {@required this.iconURL,
      @required this.iconText,
      @required this.actionIndex,
      this.imgURL,
      this.imgData});

  void newFunc(input) {
    if (input == "Favorite") {
      print("click favorite");
    }
  }

  @override
  _ImageDetailButtonState createState() => _ImageDetailButtonState();
}

class _ImageDetailButtonState extends State<ImageDetailButton> {
  bool isInfo = false;
  bool isSave = false;
  bool isApply = false;
  bool isFavorite = false;

  Future<Uint8List> getData(imgURL) async {
    Response<List<int>> res = await Dio().get<List<int>>(imgURL,
        options: Options(responseType: ResponseType.bytes));
    return Uint8List.fromList(res.data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
      // padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                // color: isDarkMode? Colors.grey[350].withOpacity(0.35) : Colors.white.withOpacity(0.05),
                color: Colors.grey[350].withOpacity(0.35),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              padding: EdgeInsets.zero,

              onPressed: () async {
                if (widget.actionIndex == 0) {
                  print("info");
                  isInfo = true;

                  showDialogInfo(context, widget.imgData);
                } else if (widget.actionIndex == 1) {
                  print("save");

                  // ----------------Android
                  if (Platform.isAndroid) {
                    print("Android");

                    print("url image: ${widget.imgURL}");

                    // Uint8List _data = await getData(
                    //     "https://i.pinimg.com/originals/f8/59/70/f85970920f913b58e5fcde0559b5879e.jpg");
                    Uint8List _data = await getData(widget.imgURL);

                    // File file = new File(
                    //     "https://i.pinimg.com/originals/f8/59/70/f85970920f913b58e5fcde0559b5879e.jpg");

                    File file = new File(widget.imgURL);

                    String basenameImg = basename(file.path);

                    print("basename: $basenameImg");

                    print("_data $_data");
                    //
                    // Save to album.

                    bool success = await ImageSave.saveImage(_data, basenameImg,
                        albumName: "WallpapersByGemmob");

                    print("result: $success");

                    showTopSnackBar(
                        context,
                        MySnackBarSuccess(
                          messageText: "Saved successfully!",
                        ),
                        displayDuration: Duration(milliseconds: 1000));
                  }
                  if (Platform.isIOS) {
                    print("IOS ");
                  }
                  isSave = true;
                } else if (widget.actionIndex == 2) {
                  print("apply");
                  isApply = true;

                  print("imgURL ${widget.imgURL}");

                  if (Platform.isAndroid) {
                    // showMyDialogSetWallpaper(context,
                    //     "https://img.freepik.com/free-vector/colorful-palm-silhouettes-background_23-2148541792.jpg?size=626&ext=jpg");
                    showMyDialogSetWallpaper(context, widget.imgURL);
                  }

                  if (Platform.isIOS) {
                    showMyDialogIOSSetWallpaper(context);
                  }
                } else {
                  setState(() {
                    if (!isFavorite) {
                      print("favorite");
                      isFavorite = true;
                      widget.iconURL = Icons.favorite;
                    } else {
                      isFavorite = false;
                      widget.iconURL = Icons.favorite_border_rounded;
                    }
                    ;
                  });
                }
              },

              icon: Icon(
                widget.iconURL,
                color: isFavorite
                    ? Colors.red
                    : isDarkMode
                        ? Colors.black
                        : Colors.white,
                size: 40,
              ),
              // style: TextButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(7.5),
              // )),
            ),
          ),
        ],
      ),
    );
  }

  // _save() async {
  //   if (Platform.isAndroid) {
  //     await _askPermission();
  //   }
  //   var response = await Dio().get(
  //       "https://i.pinimg.com/originals/3b/8a/d2/3b8ad2c7b1be2caf24321c852103598a.jpg",
  //       options: Options(responseType: ResponseType.bytes));
  //   final result = await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(response.data),
  //       name: "custom2");
  //   print(result);
  //   // Navigator.pop(context);
  // }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    } else {
      /* PermissionStatus permission = */ await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}

class MySnackBarSuccess extends StatelessWidget {
  final String messageText;

  MySnackBarSuccess({@required this.messageText});

  @override
  Widget build(BuildContext context) {
    return CustomSnackBar.success(
      backgroundColor: Colors.black54,
      message: messageText,
      textStyle: TextStyle(
        color: Colors.white,
      ),
      iconRotationAngle: 0,
      icon: null,
    );
  }
}
