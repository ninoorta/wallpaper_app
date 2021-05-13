import 'package:wallpaper_app/constants.dart';
import 'package:flutter/material.dart';




class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
      child: Divider(
        thickness: 1.0,
      ),
    );
  }
}