import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attandance/model/class_data.dart';
import '../helper/database.dart';

class test_bottom extends StatefulWidget {
  @override
  _test_bottomState createState() => _test_bottomState();
}

List<String> routine = [];

class _test_bottomState extends State<test_bottom> {
  String title;
  String initial_present;
  String initial_total;
  TextEditingController _title;
  TextEditingController _initial_present;
  TextEditingController _initial_total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
    );
  }
}

class bottom extends StatelessWidget {
  String title;
  String initial_present;
  String initial_total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Text(
                'Title',
                style: TextStyle(fontSize: 20, letterSpacing: 3),
              ),
              TextField(
                autofocus: true,
                onChanged: (text) {
                  title = text;
                },
                cursorColor: Colors.black,
                cursorRadius: Radius.circular(5),
                maxLength: 20,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: " Enter Subject name",
                  hintStyle: TextStyle(fontSize: 20),
                ),
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Initial Present',
                      style: TextStyle(fontSize: 20, letterSpacing: 3),
                    ),
                    TextField(
                      onChanged: (text) {
                        initial_present = text;
                        if (text == null) {
                          initial_present = '0';
                        }
                      },
                      cursorColor: Colors.black,
                      cursorRadius: Radius.circular(5),
                      // keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0",
                        hintStyle: TextStyle(fontSize: 20),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Initial Total',
                      style: TextStyle(fontSize: 20, letterSpacing: 3),
                    ),
                    TextField(
                      onChanged: (text) {
                        initial_total = text;
                      },
                      // keyboardType: TextInputType.number,

                      cursorColor: Colors.black,

                      cursorRadius: Radius.circular(5),
                      decoration: InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 20),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Routine_checker(
            routine: routine,
          ),

          //

          RaisedButton(
            onPressed: () {
              if (title != null) {
                if (initial_total == null) {
                  initial_total = '0';
                  initial_present = '0';
                }
                print('Initial data');
                print(initial_present);
                print(initial_total);
                print(routine);
                print('---------');
                ClassData classdata = ClassData(
                    routine: routine,
                    title: title,
                    present: int.parse(initial_present),
                    total: int.parse(initial_total),
                    percentage: int.parse(initial_total) > 0
                        ? int.parse(initial_present) *
                            100 /
                            int.parse(initial_total)
                        : 0.00);
                Provider.of<All_class_data>(context, listen: false)
                    .AddData(classdata);

                routine = [];
                Navigator.pop(context);
              }
            },
            child: Text('submit'),
          ),
        ],
      ),
    );
  }
}

class Routine_checker extends StatefulWidget {
  Routine_checker({@required this.routine});
  List<String> routine;

  @override
  _Routine_checkerState createState() => _Routine_checkerState();
}

class _Routine_checkerState extends State<Routine_checker> {
  @override
  void initState() {
    super.initState();
    setState(() {
      routine = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Day(isChecked: false, name: 'Satday'),
          Day(isChecked: false, name: 'Sunday'),
          Day(isChecked: false, name: 'Monday'),
          Day(isChecked: false, name: 'Tuesday'),
          Day(isChecked: false, name: 'Wednesday'),
          Day(isChecked: false, name: 'Thursday'),
          Day(isChecked: false, name: 'Friday'),
        ],
      ),
    );
  }
}

class Day extends StatefulWidget {
  Day({@required this.name, @required this.isChecked});
  final name;
  bool isChecked;

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        {
          setState(() {
            widget.isChecked = widget.isChecked == true ? false : true;
            if (widget.isChecked == true) {
              routine.add(widget.name);
            } else {
              routine.remove(widget.name);
            }
            print(routine);
          });
        }
      },
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: widget.isChecked ? Colors.blue : Colors.grey),
            ),
          ),
          Text(widget.name),
        ],
      )),
    );
  }
}
