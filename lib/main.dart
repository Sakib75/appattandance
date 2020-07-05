import 'package:flutter/material.dart';
import 'view/home_screen.dart';
import 'package:provider/provider.dart';
import 'model/class_data.dart';
import 'view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => All_class_data(),
      child: MaterialApp(
        theme: ThemeData.light(),
        home: Start(),
      ),
    );
  }
}

