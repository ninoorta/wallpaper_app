import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';

class FooterCopyright extends StatelessWidget {
  const FooterCopyright({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60.0,
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Copyright @2021, All Rights Reserved",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        "Developed by",
                        style:
                        TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      Text(
                        "Gemmob",
                        style: kCopyrightTextStyle,
                      )
                    ],
                  ),
                ]),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}
