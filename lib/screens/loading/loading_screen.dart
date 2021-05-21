import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/home/home_screen.dart';
import 'package:wallpaper_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



// service test
import 'package:wallpaper_app/services/categoryService.dart';

import 'package:wallpaper_app/models/categories/categories.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();

    print("stay at loading screen");
     // CategoryData();
    // getCategoryData()
   // final categoryData =  CategoryService.getCategoryData();
    test();
  }

  void CategoryData() async {
    // var categoryData = await CategoryModel.getCategoryData();
    // var categoryResponse = await CategoryModel.getCategoryData();
    // var categoryData = categoryResponse["data"];
    // have category data -> go to home screen
    // print("data at loading screen: $categoryData");

    // Navigator.push(context, MaterialPageRoute(builder: (context){
    //   return HomeScreen(
    //     categoryData: categoryData,
    //   );
    // }));

  }

  Future<void> test() async {
    // print("before await test");
    // final data = await CategoryService.getCategoryData();

    var data = await CategoryService.getCategoryData();
    // print('in loading screen ${data}');

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'categoryData': data
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500].withOpacity(0.25),
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

}
