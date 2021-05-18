import 'package:flutter/material.dart';
import '../../../utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.075,
        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find Wallpaper...',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (valueChanged) {
                    print(valueChanged);
                  },
                ),
              ),
              SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.black.withOpacity(0.5),
              )
            ],
          ),
        ));
  }
}
