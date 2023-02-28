import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/theme/mytheme.dart';

import 'views/home.dart';

void main() async {
  //Initialize hive
  await Hive.initFlutter();

  //Open hive box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: myTheme,
      home: const HomePage(),
    );
  }
}
