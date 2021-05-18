import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

Future<void> showDialogInfo(BuildContext context) async {
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
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel nisl interdum, interdum ligula rutrum,'
                      ' finibus orci. Cras eu eleifend erat. Nulla tempus vel nibh id feugiat.'
                      ' Praesent porttitor nulla eget ipsum posuere, id volutpat tortor viverra.'
                      ' Fusce faucibus, turpis eu malesuada egestas, eros eros facilisis ante, '
                      'vel fringilla lacus orci tincidunt velit. Pellentesque malesuada sem libero,'
                      ' id consectetur nisl sollicitudin at. Curabitur gravida placerat rutrum.'
                      ' Cras ornare elit at arcu varius blandit. Phasellus congue lorem ex. ',
              style: TextStyle(

              ),),
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
