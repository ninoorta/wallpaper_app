import 'package:flutter/material.dart';
import 'package:wallpaper_app/utilities/constants.dart';
import 'screens/home/home_screen.dart';
import 'screens/category_detail/category_detail_screen.dart';
import 'screens/image_detail/image_detail_screen.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/category': (context) => CategoryDetail(),
        '/image': (context) => ImageDetail(),                   // need to custom with id
      },
    );
  }
}
