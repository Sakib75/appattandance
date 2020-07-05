import 'package:flutter/material.dart';
import 'package:attandance/view/home_screen.dart';
class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  bool isMenuOpen = false;
  double menu_width = 250;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              setState(() {
               isMenuOpen = isMenuOpen == true ? false : true;
              });
            },
            child: Icon(Icons.menu,color: Colors.black,)),
          actions: [Icon(Icons.question_answer,color: Colors.black,)],
        ),
      body: Stack(
          children: [
          AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: isMenuOpen ? 0.5 : 1.0,
              child: InkWell(
                onTap: () {
                  setState(() {
      isMenuOpen = true ? false : true;
                  });
                },
              child: Container(
                color: Colors.white,
                child: HomeScreen(),
                ),
              ),
            ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isMenuOpen ? 0 : -menu_width,
        child: Container(
              height: MediaQuery.of(context).size.height,
              width: menu_width,
              color:  Colors.blue,
            ),
          )
          ],
        ),
    );
  }
}