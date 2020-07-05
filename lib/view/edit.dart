import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attandance/model/class_data.dart';

class edit extends StatefulWidget {
  @override
  _editState createState() => _editState();
}

List<String> final_routine = [];

class _editState extends State<edit> {
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

class EditItem extends StatelessWidget {
  EditItem(
      {@required this.title,
      @required this.id,
      @required this.current_present,
      @required this.current_total,
      @required this.index,
      @required this.routine});
  String title;
  int id;
  String current_present;
  String current_total;
  int index;
  List<String> routine;

  @override
  Widget build(BuildContext context) {
    List<String> old_routine =
        Provider.of<All_class_data>(context).Class_data[index].routine;
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
                  hintText: title,
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
                      'Present',
                      style: TextStyle(fontSize: 20, letterSpacing: 3),
                    ),
                    TextField(
                      onChanged: (text) {
                        current_present = text;
                        if (text == null) {
                          current_present = current_present;
                        }
                      },
                      cursorColor: Colors.black,
                      cursorRadius: Radius.circular(5),
                      // keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: current_present,
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
                      'Total',
                      style: TextStyle(fontSize: 20, letterSpacing: 3),
                    ),
                    TextField(
                      onChanged: (text) {
                        current_total = text;
                      },
                      // keyboardType: TextInputType.number,

                      cursorColor: Colors.black,

                      cursorRadius: Radius.circular(5),
                      decoration: InputDecoration(
                        hintText: current_present,
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

          Routine_edit(old_routine: old_routine),

          //

          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  if (title != null) {
                    if (current_total == null) {
                      current_total = '0';
                      current_present = '0';
                    }
                    ClassData classdata = ClassData(
                        id: id,
                        routine: final_routine,
                        title: title,
                        present: int.parse(current_present),
                        total: int.parse(current_total),
                        percentage: int.parse(current_total) > 0
                            ? int.parse(current_present) *
                                100 /
                                int.parse(current_total)
                            : 0.00);
                    Provider.of<All_class_data>(context, listen: false)
                        .EditData(classdata, index);

                    routine = [];
                    Navigator.pop(context);
                  }
                },
                child: Text('edit'),
              ),
              RaisedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  print('Hi there delilah');
                  try {
                    await Provider.of<All_class_data>(context, listen: false)
                        .delete_class(index);
                  } catch (e) {
                    print(e);
                  }

                  print('dont you worry about');
                  // Navigator.pop(context);
                },
                child: Text('Delete'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Routine_edit extends StatefulWidget {
  const Routine_edit({
    Key key,
    @required this.old_routine,
  }) : super(key: key);

  final List<String> old_routine;

  @override
  _Routine_editState createState() => _Routine_editState();
}

class _Routine_editState extends State<Routine_edit> {
  List<String> routine;
  List<String> deleted_routine;

  @override
  void initState() {
    super.initState();
    setState(() {
      routine = [];
      deleted_routine = [];
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
          Day(
              isChecked: widget.old_routine.contains('Saturday') ? true : false,
              name: 'Saturday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
          Day(
              isChecked: widget.old_routine.contains('Sunday') ? true : false,
              name: 'Sunday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
          Day(
              isChecked: widget.old_routine.contains('Monday') ? true : false,
              name: 'Monday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
          Day(
              isChecked: widget.old_routine.contains('Tuesday') ? true : false,
              name: 'Tuesday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
          Day(
              isChecked:
                  widget.old_routine.contains('Wednesday') ? true : false,
              name: 'Wednesday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
          Day(
              isChecked: widget.old_routine.contains('Thursday') ? true : false,
              name: 'Thursday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
          Day(
              isChecked: widget.old_routine.contains('Friday') ? true : false,
              name: 'Friday',
              old_routine: widget.old_routine,
              routine: routine,
              deleted_routine: deleted_routine),
        ],
      ),
    );
  }
}

class Day extends StatefulWidget {
  Day(
      {@required this.name,
      @required this.isChecked,
      @required this.old_routine,
      @required this.routine,
      @required this.deleted_routine});
  String name;
  bool isChecked;
  List<String> old_routine;
  List<String> routine;
  List<String> deleted_routine;

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.isChecked = widget.isChecked == true ? false : true;
          if (widget.isChecked == true) {
            widget.routine.add(widget.name);
            if (widget.deleted_routine.contains(widget.name)) {
              widget.deleted_routine.remove(widget.name);
            }
          } else {
            widget.routine.remove(widget.name);
            widget.deleted_routine.add(widget.name);
          }

          final_routine = widget.old_routine + widget.routine;
          widget.deleted_routine.forEach((element) {
            if (final_routine.contains(element)) {
              final_routine.remove(element);
            }
          });
          print(final_routine);
        });
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
