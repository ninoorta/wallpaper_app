import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './components/body.dart';
import './components/sideNav.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  color: Colors.black,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          )),
      drawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          child: Drawer(
            child: SideNav(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: HomeBody(),
      ),
    );
  }
}