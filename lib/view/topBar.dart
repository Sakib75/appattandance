import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attandance/model/class_data.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'test.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var percentage =
        Provider.of<All_class_data>(context).overall_percentage() / 100;

    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.25 - 50;
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Goal",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "60%",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
//                            ClassData classdata = ClassData(title: 'Hi',present: 0,total: 0,percentage: 0.0);
//                            Provider.of<all_Class_data>(context,listen: false).AddData(classdata);
                            bottomsheet(context);
                          },
                          child: Container(
                            height: 35,
                            width: 85,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.white.withOpacity(0.5),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Center(
                                    child: Text(
                                  'Add Subject',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: LiquidCircularProgressIndicator(
                            value: percentage, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(Colors.blueAccent
                                .withOpacity(
                                    0.5)), // Defaults to the current Theme's accentColor.
                            backgroundColor: Colors
                                .white, // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.white,
                            borderWidth: 5.0,
                            direction: Axis
                                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Overall \nAttendance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.5),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              (percentage * 100).toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hottest deal",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future bottomsheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return bottom();
        });
  }
}
