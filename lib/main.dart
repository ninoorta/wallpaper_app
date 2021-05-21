import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/loading/loading_screen.dart';
import 'package:wallpaper_app/utilities/constants.dart';

// screens
import 'screens/home/home_screen.dart';
import 'screens/category_detail/category_detail_screen.dart';
import 'screens/image_detail/image_detail_screen.dart';
import 'screens/about/about_screen.dart';

// services
import 'services/networking.dart';


// model
import './models/categories/categories.dart';

void main() async  {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/': (context) => LoadingScreen(),
        '/home': (context) => HomeScreen(),
        '/category': (context) => CategoryDetail(), // need to custom with id
        '/image': (context) => ImageDetail(), // need to custom with id
        '/account': (context) => About(),
      },
    );
  }
}
