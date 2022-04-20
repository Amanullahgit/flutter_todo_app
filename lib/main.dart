// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';

main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.white)),
  ));
}
