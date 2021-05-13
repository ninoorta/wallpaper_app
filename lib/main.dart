import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/constants.dart';
import './screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper app',
      //theme : later use for custom theme
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        // textTheme: Theme.of(context).textTheme.apply(
        //
        // ),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomeScreen(),
    );
  }
}
