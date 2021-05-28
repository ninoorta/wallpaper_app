import 'package:flutter/material.dart';

Future<void> showDialogNotifcation(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user do not need to tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Alert!')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Text(
                    'We are sorry. This feature will be coming soon!',
                    style: TextStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        // actionsPadding: EdgeInsets.symmetric(horizontal: 15.0),
        elevation: 24.0,
      );
    },
  );
}
