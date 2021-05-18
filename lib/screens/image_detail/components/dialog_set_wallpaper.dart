import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
          Row(
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
                  var file = await DefaultCacheManager().getSingleFile(imgURL);
                  final String result =
                      await WallpaperManager.setWallpaperFromFile(
                          file.path, location);
                  // final String result =
                  //     await WallpaperManager.setWallpaperFromAsset(
                  //         url, location);
                  print('set wallpaper result $result');

                  Navigator.of(context).pop();


                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: kDialogTextButtonStyle,
                    elevation: 0),
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
                  var file = await DefaultCacheManager().getSingleFile(imgURL);
                  final String result =
                      await WallpaperManager.setWallpaperFromFile(
                          file.path, location);
                  // final String result =
                  //     await WallpaperManager.setWallpaperFromAsset(
                  //         assetPath, location);
                  print('set wallpaper result $result');

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  textStyle: kDialogTextButtonStyle,
                  elevation: 0,
                ),
              ),
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
                  var file = await DefaultCacheManager().getSingleFile(imgURL);
                  final String result =
                      await WallpaperManager.setWallpaperFromFile(
                          file.path, location);
                  print('set wallpaper result $result');

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: kDialogTextButtonStyle,
                    elevation: 0),
              ),
            ],
          ),
        ],
        // actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
        elevation: 24.0,
      );
    },
  );
}
