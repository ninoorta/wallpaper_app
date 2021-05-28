import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                      int sensitivity = 8;
                      if (details.delta.dx > sensitivity) {
                        // Right Swipe
                        print("swipe right");
                        Navigator.pop(context);
                      } else if (details.delta.dx < -sensitivity) {
                        //Left Swipe
                      }
                    },
                    child: Container(
                      color: Colors.grey[50],
                      child: Center(
                        child: Text(
                          "Coming soon!",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.875,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
