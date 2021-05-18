import 'dart:typed_data';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
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

class ImageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/image1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center(
          //   child: Text("Hello background"),
          // )
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15.0),
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageDetailButton(
                    iconURL: "assets/icons/info.svg",
                    iconText: "Info",
                    actionIndex: 0,
                  ),
                  ImageDetailButton(
                    iconURL: "assets/icons/save.svg",
                    iconText: "Save",
                    actionIndex: 1,
                  ),
                  ImageDetailButton(
                    iconURL: "assets/icons/apply.svg",
                    iconText: "Apply",
                    actionIndex: 2,
                  ),
                  ImageDetailButton(
                    iconURL: "assets/icons/unlike.svg",
                    iconText: "Favorite",
                    actionIndex: 3,
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class ImageDetailButton extends StatefulWidget {
  String iconURL;
  final String iconText;

  final int actionIndex;

  ImageDetailButton(
      {@required this.iconURL,
      @required this.iconText,
      @required this.actionIndex});

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

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('$path');
  //
  //   final file =
  //       await File('${(await getApplicationDocumentsDirectory()).path}/$path')
  //           .create(recursive: true);
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return file;
  // }

  // final _imageSaver = ImageSaver();
  //
  // Future<void> saveAssetImage(String imagePath, String directoryPath) async {
  //   // 1
  //   final urls = [
  //     imagePath,
  //   ];
  //   // 2
  //   List<Uint8List> bytesList = [];
  //   for (final url in urls) {
  //     final bytes = await rootBundle.load(url);
  //     bytesList.add(bytes.buffer.asUint8List());
  //   }
  //   // 3
  //   final res = await _imageSaver.saveImages(
  //       imageBytes: bytesList, directoryName: directoryPath);
  //   // 4
  // }

  // var imgPath;

  // Uint8List _data;

  // test with package image_save
  Future<Uint8List> getData(imgURL) async {
    Response<List<int>> res = await Dio().get<List<int>>(imgURL,
        options: Options(responseType: ResponseType.bytes));
    return Uint8List.fromList(res.data);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          TextButton(
            onPressed: () async {
              if (widget.actionIndex == 0) {
                print("info");
                isInfo = true;

                showDialogInfo(context);
              } else if (widget.actionIndex == 1) {
                print("save");

                // // print("create new directory");
                // // await new Directory("wallpaper_app").create();
                // // _save();
                //
                // // bool success = await ImageSave.saveImage(data, "demo.gif", albumName: "demo");
                //
                // //
                // // File temp =
                // // await getImageFileFromAssets("assets/images/image1.jpg");
                // // print("file data $temp");
                //
                // final extDir =
                //     await getExternalStorageDirectory(); // only support for Android
                //
                // print('extDir $extDir');
                //
                // // Path of file
                // final myImagePath = '${extDir.path}/Wallpapers_Pictures';
                //
                // // Create directory inside where file will be saved
                // Directory result = await new Directory(myImagePath).create();
                //
                // //
                // // print("result after create new directory $result");
                // // String basename = "image1.jpg";
                //
                // print("myImagePath: $myImagePath");

                // File copied to ext directory.
                // File newImage =
                //     await temp.copy("$myImagePath/${basename}");
                //     // await temp.copy(myImagePath);
                // print(newImage.path);

                // saveAssetImage("assets/images/image1.jpg", myImagePath); // this will save into the Picture directory and dont know how to custom it

                // use func : can save into folder but need to custom and create a specific folder like :  wallpaper-app/pictures/image1.jpg
                // other func :

                print('other try');

                // ----------------Android
                if (Platform.isAndroid) {
                  print("Android");

                  Uint8List _data = await getData(
                      "https://i.pinimg.com/originals/f8/59/70/f85970920f913b58e5fcde0559b5879e.jpg");

                  File file = new File(
                      "https://i.pinimg.com/originals/f8/59/70/f85970920f913b58e5fcde0559b5879e.jpg");
                  String basenameImg = basename(file.path);

                  print("basename: $basenameImg");

                  print("_data $_data");
                  //
                  // Save to album.

                  bool success = await ImageSave.saveImage(_data, basenameImg,
                      albumName: "WallpaperByGemmob");

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

                // ----------------
                //
                // //Get this App Document Directory
                // final Directory _appDocDir = await getApplicationDocumentsDirectory();
                // print("_appDocDir $_appDocDir");
                // //App Document Directory + folder name
                // final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/$folderName/');
                // print("_appDocDirFolder $_appDocDirFolder");
                // if(await _appDocDirFolder.exists()){ //if folder already exists return path
                //   return _appDocDirFolder.path;
                // }else{//if folder not exists create folder and then return its path
                //   final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
                //   return _appDocDirNewFolder.path;
                // }
                //

                //

                isSave = true;
              } else if (widget.actionIndex == 2) {
                print("apply");
                isApply = true;

                if (Platform.isAndroid) {
                  showMyDialogSetWallpaper(context,
                      "https://img.freepik.com/free-vector/colorful-palm-silhouettes-background_23-2148541792.jpg?size=626&ext=jpg");
                }

                if (Platform.isIOS) {
                  showMyDialogIOSSetWallpaper(context);
                }
              } else {
                setState(() {
                  if (!isFavorite) {
                    print("favorite");
                    isFavorite = true;
                    widget.iconURL = "assets/icons/like.svg";
                  } else {
                    isFavorite = false;
                  }
                  ;
                });
              }
            },
            child: SvgPicture.asset(
              widget.iconURL,
              color: isFavorite ? Colors.red : Colors.white,
              width: 35,
              height: 35,
            ),
            style: TextButton.styleFrom(
                // padding: EdgeInsets.all(10.0),
                // backgroundColor:
                //     // Color(0xFFDBD8D5).withOpacity(0.25),
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.5),
              // side: BorderSide(
              //     color: Color(0xFFDBD8D5)
              //         .withOpacity(0.25)),
            )),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              widget.iconText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
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
      backgroundColor: Colors.transparent,
      message: messageText,
      textStyle: TextStyle(
        color: Colors.white,
      ),
      iconRotationAngle: 0,
      icon: null,
    );
  }
}
