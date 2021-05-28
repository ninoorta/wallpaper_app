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
    //  test();
    getData();
  }

  Future<void> getData() async {
    try {
      print("start in loading screen ${DateTime.now()}");

      var categoryData = await CategoryService.getCategoryDataNew();
      // print('in loading screen ${categoryData}');

      print("end in loading screen ${DateTime.now()}");

      // debugPrint("categoryData in debug loading $categoryData", wrapWidth: 1024);

      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'categoryData': categoryData
      });
    } catch (err) {
      throw Exception("error in loading screen $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       // width: double.infinity,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Image.asset(
      //             "assets/images/gemmob_logo.png",
      //             height: 100,
      //             width: 100,
      //           ),
      //           // SizedBox(height: 100,),
      //           SpinKitCircle(
      //             color: Colors.white,
      //             size: 65.0,
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/gemmob_logo.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
          Positioned.fill(
            top: 300,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SpinKitCircle(
                color: Colors.white,
                size: 65.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
