import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/class_data.dart';

final String tableName = "attandance";
final String Column_id = "id";
final String Column_title = "title";
final String Column_present = "present";
final String Column_total = "total";
final String Column_routine = "routine";
final String Column_percentage = "percentage";

class AttadanceHelper {
  Database db;
  List<ClassData> allclass;

  AttadanceHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_title TEXT,$Column_present INTEGER ,$Column_total INTEGER,$Column_percentage REAL,$Column_routine TEXT)");
    }, version: 1);
    await print('***database created***');
  }

  Future<List<ClassData>> getAllTask() async {
    print('***Getting all data***');
    final List<Map<String, dynamic>> tasks =
        await Future.delayed(Duration(seconds: 4), () => db.query(tableName));

    return List.generate(tasks.length, (i) {
      // print('from database');
      // print(tasks[i][Column_title]);
      // print(tasks[i][Column_routine]);
      try {
        print(jsonDecode(tasks[i][Column_routine]));
        print(jsonDecode(tasks[i][Column_routine]).runtimeType);
      } catch (e) {
        print(e);
      }

      List<String> _routine = [];
      try {
        jsonDecode(tasks[i][Column_routine]).forEach((element) {
          _routine.add(element);
        });
      } catch (err) {
        print(err);
      }

      // print(_routine);
      // print(_routine.runtimeType);

      return ClassData(
          title: tasks[i][Column_title],
          id: tasks[i][Column_id],
          present: tasks[i][Column_present],
          total: tasks[i][Column_total],
          percentage: tasks[i][Column_percentage].toDouble(),
          routine: _routine);
    });
  }

  Future<void> insertTask(ClassData task) async {
    try {
      await Future.delayed(
          Duration(seconds: 0),
          () => db.insert(tableName, task.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace));
    } catch (_) {
      print(_);
    }
    print('***data inserted***');
  }

  Future<void> updateSubject(ClassData task) async {
    print('***Updating data to database***');
    return await db
        .update(tableName, task.toMap(), where: "id = ?", whereArgs: [task.id]);
  }

  Future<void> deleteTask(ClassData task) async {
    print("***deleting sub ${task.title}***");
    if (task.id == null) {
      task.id = 0;
    }
    return await db
        .delete(tableName, where: 'title = ?', whereArgs: [task.title]);
  }

  Future<void> deleteDatabase() async {
    print('***deleting full database***');
    return await db.delete(tableName);
  }
}
