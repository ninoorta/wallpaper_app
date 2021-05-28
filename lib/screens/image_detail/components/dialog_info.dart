import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

Future<void> showDialogInfo(BuildContext context, imageData) async {
  Map imgData = imageData;
  print("imgData in showDialogInfo $imgData");
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user do not need to tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('This image\'s information')),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Name: ${imgData["name"]}',
                style: TextStyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Quality: ${imgData["info"]}'),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        // actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
        elevation: 24.0,
      );
    },
  );
}
