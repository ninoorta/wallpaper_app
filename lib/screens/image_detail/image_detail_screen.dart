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

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;

    print("arguments in imageDetail screen $arguments");

    imageData = arguments["chosenImageData"];
    imagesInCategory = arguments["imagesInCategory"];
    initialImageID = imageData["id"];
    initialImageIndex = arguments["currentIndex"];

    print("chosen image data $imageData");

    final PageController _controller = PageController(
        initialPage: initialImageIndex, keepPage: true, viewportFraction: 1);

    return SafeArea(
      child: Scaffold(
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
        child: BuildImageDetail(
          size: size,
          imageData: imageData,
        ),
      )

          // later
          //     body: PageView(
          //         controller: _controller,
          //         scrollDirection: Axis.horizontal,
          //         onPageChanged: (index) {
          //           print("changed to $index");
          //         },
          //         children: [
          //           Row(
          //             children: [
          //               Container(
          //                 width: size.width,
          //                 child: ListView.builder(
          //                   controller: ScrollController(
          //                   ),
          //                   scrollDirection: Axis.horizontal,
          //                   shrinkWrap: true,
          //                   // physics: NeverScrollableScrollPhysics(),
          //                   itemCount: imagesInCategory.length,
          //                   itemBuilder: (context, index) {
          //                     return BuildImageDetail(
          //                         size: size, imageData: imagesInCategory[index]);
          //                   },
          //                 ),
          //               ),
          //             ],
          //           ),
          // ])

          // later

          ),

      // child: PageView(
      //     scrollDirection: Axis.horizontal,
      //     controller: _controller,
      //     children: <Widget>[
      //       ListView.builder(
      //         itemCount: imagesInCategory.length,
      //         itemBuilder: (context, index) {
      //           return BuildImageDetail(size: size, imageData: imagesInCategory[index]);
      //         },
      //       ),
      //     ]),
    );
  }
}

class BuildImageDetail extends StatelessWidget {
  const BuildImageDetail({
    Key key,
    @required this.size,
    @required this.imageData,
  }) : super(key: key);

  final Size size;
  final Map imageData;

  @override
  Widget build(BuildContext context) {
    print("device width ${size.width}");
    print("device height ${size.height}");
    return Stack(
      children: <Widget>[
        Container(
          height: size.height,
          width: size.width,
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
          width: size.width,
          height: size.height,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: "https://mkt.h2c.us/wall/photo/${imageData["url"]}",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // container for back button
              Container(
                width: size.width,
                margin: EdgeInsets.all(15.0),
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.grey[200]),
                  child: BackButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageDetailButton(
                    iconURL: Icons.info_outline_rounded,
                    iconText: "Info",
                    actionIndex: 0,
                    imgData: imageData,
                  ),
                  ImageDetailButton(
                      iconURL: Icons.save_alt_rounded,
                      iconText: "Save",
                      actionIndex: 1,
                      imgURL:
                          "https://mkt.h2c.us/wall/photo/${imageData["url"]}"),
                  ImageDetailButton(
                      iconURL: Icons.brush_rounded,
                      iconText: "Apply",
                      actionIndex: 2,
                      imgURL:
                          "https://mkt.h2c.us/wall/photo/${imageData["url"]}"),
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
      margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFC1BBB6).withOpacity(0.65),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                )
              ],
            ),
            width: 50.0,
            height: 50.0,
            child: TextButton(
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
              child: Icon(
                widget.iconURL,
                color: isFavorite ? Colors.red : Colors.white,
                size: 35,
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.5),
              )),
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
