import 'package:flutter/material.dart';
import 'Welcome.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),

    home: Welcome(),
  ));
}




