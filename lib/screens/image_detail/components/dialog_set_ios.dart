import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

Future<void> showMyDialogIOSSetWallpaper(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user do not need to tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Where to set?')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You can not use this function because IOS\'s policy'),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  'Cancel',
                  style: kDialogTextButtonStyle,
                ),
                onPressed: () async {
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
