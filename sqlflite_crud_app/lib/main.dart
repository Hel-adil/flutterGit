import 'package:flutter/material.dart';
import 'package:sqlflite_crud_app/AddBook.dart';
import 'Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      home: Home(),
      routes: {
        "addbook": (context) => AddBook(),
      },
    );
  }
}
