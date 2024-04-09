import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_todoapp/data/database.dart';
import 'package:test_todoapp/utility/dialog_box.dart';

import '../utility/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _myBox = Hive.box('myBox');

  @override
  void initState() {
    //if this the first time user is ipening the app, the create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //if theres is an existing data
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();
  // List toDoList = [
  //   [
  //     'Make Tutorial',
  //     true,
  //   ],
  //   [
  //     'DO Execise',
  //     true,
  //   ]
  // ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewtask() {
    if (_controller.toString().isEmpty) {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("TODO cannot be empty")));
    }
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewtask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void shareFunction(index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TO DO",
        ),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskname: db.toDoList[index][0],
            taskComplete: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            shareFunction: (context) => shareFunction(index),
          );
        },
      ),
    );
  }
}
