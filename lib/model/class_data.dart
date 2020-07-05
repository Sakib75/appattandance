import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import '../helper/database.dart';

class ClassData {
  int id;
  String title;
  int total;
  int present;
  double percentage;
  String remarks;
  List<String> routine;
  ClassData(
      {this.id,
      this.title,
      this.total,
      this.percentage,
      this.present,
      this.routine});
  Map<String, dynamic> toMap() {
    print('***Converting to map***');
    return {
      Column_title: this.title,
      Column_present: this.present,
      Column_total: this.total,
      Column_percentage: this.percentage,
      Column_routine: jsonEncode(this.routine),
    };
  }
}

class All_class_data extends ChangeNotifier {
  AttadanceHelper backend = AttadanceHelper();
  List<ClassData> Class_data = [];

  void AddDatabase(List<ClassData> allclassData) {
    Class_data = allclassData.reversed.toList();

    notifyListeners();
  }

  void AddData(ClassData classData) {
    Class_data.insert(0, classData);

    backend.insertTask(classData);
    notifyListeners();
  }

  void EditData(ClassData classData, int index) {
    print('***Editing starts***');
    Class_data[index] = classData;
    backend.updateSubject(classData);
    notifyListeners();
  }

  void mark_present(int index) {
    print('***marking present***');
    Class_data[index].present = Class_data[index].present + 1;
    Class_data[index].total = Class_data[index].total + 1;
    update_percentage(index);

    ClassData subject = Class_data[index];
    backend.updateSubject(subject);

    notifyListeners();
  }

  void mark_absent(int index) {
    print('***marking absent***');
    Class_data[index].total = Class_data[index].total + 1;
    update_percentage(index);

    ClassData subject = Class_data[index];
    backend.updateSubject(subject);

    notifyListeners();
  }

  void update_percentage(index) {
    Class_data[index].percentage =
        calc_percentage(Class_data[index].total, Class_data[index].present);
    ClassData subject = Class_data[index];
    backend.updateSubject(subject);
    notifyListeners();
  }

  double calc_percentage(int total, int present) {
    double percentage;
    return percentage = present / total * 100;
  }

  void delete_class(index) async {
    print('***deleting from provider***');
    sleep(Duration(seconds: 2));
    ClassData subject = Class_data[index];
    await backend.deleteTask(subject);

    Class_data.removeAt(index);

    notifyListeners();
  }

  double overall_percentage() {
    int total_class_number = 0;
    double total_perc = 0.0;
    double overall = 0.0;
    Class_data.forEach((element) {
      if (element.total > 0) {
        total_class_number = total_class_number + 1;
      }
      total_perc = total_perc + element.percentage;
    });

    overall = total_perc != 0.0 ? total_perc / total_class_number : 0;

    return overall;
  }
}
