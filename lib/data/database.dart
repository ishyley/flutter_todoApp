import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //refrence the box
  final _myBox = Hive.box('mybox');

  //run this method if this is the !st time the app is runing on the device
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Execise", false]
    ];
  }

  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
