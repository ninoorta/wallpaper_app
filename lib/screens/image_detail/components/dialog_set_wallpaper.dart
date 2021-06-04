import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../image_detail_screen.dart';

Future<void> showMyDialogSetWallpaper(BuildContext context, imgURL) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user do not need to tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Where to set?')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Which screen you would like to set this wallpaper for?'),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Home screen',
                    style: kDialogTextButtonStyle,
                  ),
                  onPressed: () async {
                    print("User chose home screen");

                    // String url = imgURL;
                    // String assetPath = imgURL;
                    int location = WallpaperManager.HOME_SCREEN;
                    var file =
                        await DefaultCacheManager().getSingleFile(imgURL);
                    final String result =
                        await WallpaperManager.setWallpaperFromFile(
                            file.path, location);
                    // final String result =
                    //     await WallpaperManager.setWallpaperFromAsset(
                    //         url, location);
                    print('set wallpaper home screen result: $result');


                    Navigator.of(context).pop();

                    showTopSnackBar(
                        context,
                        MySnackBarSuccess(
                          messageText: "Set homescreen successfully!",
                        ),
                        displayDuration: Duration(milliseconds: 1000));

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: kDialogTextButtonStyle,
                      elevation: 2),
                ),
                ElevatedButton(
                  child: Text(
                    'Lock screen',
                    style: kDialogTextButtonStyle,
                  ),
                  onPressed: () async {
                    print("User chose lock screen");

                    // String assetPath = imgURL;
                    int location = WallpaperManager.LOCK_SCREEN;
                    var file =
                        await DefaultCacheManager().getSingleFile(imgURL);
                    final String result =
                        await WallpaperManager.setWallpaperFromFile(
                            file.path, location);
                    // final String result =
                    //     await WallpaperManager.setWallpaperFromAsset(
                    //         assetPath, location);
                    print('set wallpaper lock screen result: $result');

                    Navigator.of(context).pop();

                    showTopSnackBar(
                        context,
                        MySnackBarSuccess(
                          messageText: "Set lockscreen successfully!",
                        ),
                        displayDuration: Duration(milliseconds: 1000));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: kDialogTextButtonStyle,
                    elevation: 2,
                  ),
                ),

                // later : now can only good apply for home screen, lockscreen can not set
                ElevatedButton(
                  child: Text(
                    'Both',
                    style: kDialogTextButtonStyle,
                  ),
                  onPressed: () async {
                    print("User chose both screens");

                    // String assetPath = imgURL;
                    int location = WallpaperManager.BOTH_SCREENS;
                    // final String result =
                    //     await WallpaperManager.setWallpaperFromAsset(
                    //         assetPath, location);
                    var file =
                        await DefaultCacheManager().getSingleFile(imgURL);

                    final String result =
                        await WallpaperManager.setWallpaperFromFile(
                            file.path, location);

                    print('set wallpaper both  result: $result');

                    // xiaomi + huawei fail
                    Navigator.of(context).pop();

                    showTopSnackBar(
                        context,
                        MySnackBarSuccess(
                          messageText: "Set both screens successfully!",
                        ),
                        displayDuration: Duration(milliseconds: 1000));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      textStyle: kDialogTextButtonStyle,
                      elevation: 2),
                ),
                // later

              ],
            ),
          ),
        ],
        elevation: 24.0,
      );
    },
  );
}
