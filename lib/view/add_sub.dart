import 'package:flutter/material.dart';

Future bottomsheet(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    'Title',
                    style: TextStyle(fontSize: 20, letterSpacing: 3),
                  ),
                  TextField(),
                ],
              ),
              Text('Initial present'),
              TextField(),
              Text('Initial total'),
              TextField(),
              Container(
                child: Column(
                  children: [Text('Days'), Text('Option picker')],
                ),
              ),
            ],
          ),
        );
      });
}
