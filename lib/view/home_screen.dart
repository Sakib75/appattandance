import 'package:attandance/model/class_data.dart';
import 'package:attandance/view/add_sub.dart';
import 'package:attandance/view/edit.dart';
import 'package:attandance/view/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:attandance/helper/constants.dart';
import 'package:intl/intl.dart';
import 'package:attandance/view/topBar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import '../helper/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double goal = 60.00;
  Options options = Options();
  ScrollController controller = ScrollController();
  bool showTopContainer = true;
  double topcontainer = 0;
  String today;
  List<ClassData> All_Class_data = [];
  AttadanceHelper database = AttadanceHelper();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    // weekday

    DateTime date = DateTime.now();
    today = DateFormat('EEEE').format(date);

    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topcontainer = value;
        showTopContainer = controller.offset > 50 ? false : true;
      });
    });
    // GetAll();
  }

  GetAll() async {
    print('GetAll Function called');
    All_Class_data = await database.getAllTask();
    // print(All_Class_data);
    Provider.of<All_class_data>(context, listen: false)
        .AddDatabase(All_Class_data);
  }

  @override
  Widget build(BuildContext context) {
    GetAll();
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Bar

            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: showTopContainer ? 1 : 0.25,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: showTopContainer
                    ? MediaQuery.of(context).size.height * 0.25 - 50
                    : 100,
                child:
                    Padding(padding: EdgeInsets.only(left: 20), child: options),
              ),
            ),

            //Attendance Details

            Expanded(
              child: Container(
                child: Consumer<All_class_data>(
                  builder: (context, classdata, child) {
                    return ListView.builder(
                        // shrinkWrap: true,
                        // reverse: true,
                        controller: controller,
                        itemCount: classdata.Class_data.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isToday = false;
                          double scale = 1.0;
                          if (topcontainer > 0.5) {
                            scale = index + 0.5 - topcontainer;
                            if (scale < 0) {
                              scale = 0;
                            } else if (scale > 1) {
                              scale = 1;
                            }
                          }
                          List<String> _routine;
                          try {
                            _routine = classdata.Class_data[index].routine;
                          } catch (e) {
                            print(e);
                            _routine = [];
                          }

                          // in today check

                          try {
                            if (_routine.contains(today)) {
                              isToday = true;
                            }
                          } catch (e) {
                            print(e);
                          }

                          //up of below goal
                          double percentage =
                              classdata.Class_data[index].percentage;
                          Color traffic =
                              goal > percentage ? Colors.red : Colors.green;

                          return GestureDetector(
                            onLongPress: () {
                              HapticFeedback.vibrate();
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0))),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return EditItem(
                                      id: classdata.Class_data[index].id,
                                      index: index,
                                      title: classdata.Class_data[index].title,
                                      current_present: classdata
                                          .Class_data[index].present
                                          .toString(),
                                      current_total: classdata
                                          .Class_data[index].total
                                          .toString(),
                                      routine:
                                          classdata.Class_data[index].routine,
                                    );
                                  });
                            },
                            child: Opacity(
                              opacity: 1.0,
                              child: Transform(
                                alignment: Alignment.bottomCenter,
                                transform: Matrix4.identity()
                                  ..scale(scale, scale),
                                child: Align(
                                  heightFactor: 0.7,

                                  //// title,stats,remarks

                                  child: Container(
                                      height: 150,
                                      margin: index == 0
                                          ? EdgeInsets.only(
                                              top: 50,
                                              bottom: 10,
                                              left: 20,
                                              right: 20)
                                          : EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                      decoration: tile_decor,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      title(
                                                        traffic: traffic,
                                                        classdata: classdata,
                                                        index: index,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      isToday
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(3),
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors
                                                                          .black,
                                                                      spreadRadius:
                                                                          1,
                                                                      blurRadius:
                                                                          5)
                                                                ],
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              child: Text(
                                                                "Today",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                  details(
                                                    classdata: classdata,
                                                    index: index,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Text(
                                                        'Remarks: You have to attend next 3 classes to get back on track'),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      //// Progress Indicator

                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        child:
                                                            LiquidCircularProgressIndicator(
                                                          value: classdata
                                                                  .Class_data[
                                                                      index]
                                                                  .percentage /
                                                              100, // Defaults to 0.5.
                                                          valueColor:
                                                              AlwaysStoppedAnimation(Colors
                                                                  .blue
                                                                  .withOpacity(
                                                                      0.5)), // Defaults to the current Theme's accentColor.
                                                          backgroundColor: Colors
                                                              .white, // Defaults to the current Theme's backgroundColor.
                                                          borderColor:
                                                              Colors.blueAccent,
                                                          borderWidth: 5.0,
                                                          direction: Axis
                                                              .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                                          center: Text(
                                                              "${classdata.Class_data[index].percentage.toStringAsFixed(2)}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      //// Buttons

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                Provider.of<All_class_data>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .mark_present(
                                                                        index);
                                                              },
                                                              child: Icon(
                                                                  Icons.done)),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                Provider.of<All_class_data>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .mark_absent(
                                                                        index);
                                                              },
                                                              child: Icon(Icons
                                                                  .cancel)),
                                                        ],
                                                      )
                                                    ],
                                                  ),

                                                  //Menu button

                                                  //                       GestureDetector(
                                                  //                         onTap: () {
                                                  //                           showModalBottomSheet(
                                                  //                             isScrollControlled: true,
                                                  //                             shape: RoundedRectangleBorder(
                                                  //                             borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                                                  //                             backgroundColor: Colors.white,
                                                  //                             context: context, builder: (context) {
                                                  //   return EditItem(
                                                  //     index: index,
                                                  //     title: classdata.Class_data[index].title ,
                                                  //   current_present: classdata.Class_data[index].present.toString() ,
                                                  //   current_total: classdata.Class_data[index].total.toString());
                                                  // });
                                                  //                         },

                                                  //                         child: Icon(Icons.menu,size: 15,))
                                                ],
                                              ),
                                            ],
                                          )))),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class details extends StatelessWidget {
  details({@required this.classdata, @required this.index});
  final classdata;
  final index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Attandance',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '${classdata.Class_data[index].present.toString()}/${classdata.Class_data[index].total.toString()}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class title extends StatelessWidget {
  title(
      {@required this.classdata, @required this.index, @required this.traffic});
  Color traffic;
  var classdata;
  var index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(shape: BoxShape.circle, color: traffic),
          width: 15,
          height: 15,
        ),
        Text(
          classdata.Class_data[index].title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
