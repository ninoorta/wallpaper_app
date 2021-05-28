import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/models/categories/categories.dart';
import './components/body.dart';
import './components/sideNav.dart';

class HomeScreen extends StatefulWidget {

  final categoryData;

  HomeScreen({this.categoryData});



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // void printData(){
  //   print("category catch in home screen ${this.categoryData}");
  //
  // }
  Map dataInArguments = { };
  List categoryData = [];
  List categoryDataWithoutWalpaper;

  @override
  Widget build(BuildContext context) {
    dataInArguments = ModalRoute.of(context).settings.arguments;
    categoryData = dataInArguments["categoryData"];

    // categoryDataWithoutWalpaper = categoryData.map((category) {
    //   category.remove("wallpaper");
    // }).toList();

    // print('data in home screen: $dataInArguments');
    // print('categoryData in homeScreen $categoryData');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                color: Colors.black,
                width: 30,
                height: 20,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/account");
                },
                child: SvgPicture.asset(
                  "assets/icons/account/aboutUs.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            )
          ],
        ),
      ),
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          child: Drawer(
            child: SideNav(categoryData: categoryData,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: HomeBody(
          categoryData: categoryData,
        ),
      ),
    );
  }
}
