import 'package:flutter_svg/svg.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import 'package:flutter/material.dart';


class TopSidenavContent extends StatelessWidget {
  const TopSidenavContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            iconSize: 50.0,
            icon: SvgPicture.asset(
              'assets/icons/crown.svg',
            ),
          ),
          Text(
            "get premium today".toUpperCase(),
            style: kSecondaryLabelTextStyle,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
            child: Text(
              "Remove Ads & Unlock all wallpapers",
              style: TextStyle(color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(
            width: 150.0,
            child: TextButton(
              onPressed: () {
                print('user click get premium');
              },
              child: Text(
                "Get Premium".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Color(0xff304EFD)),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}