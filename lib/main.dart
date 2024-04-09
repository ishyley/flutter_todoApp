import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_todoapp/Pages/home_page.dart';

Future<void> main() async {
  //init hive
  await Hive.initFlutter();

  //open A box
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
