import 'package:flutter/material.dart';
import 'package:olx/RouteGenerator.dart';
import 'package:olx/View/Login.dart';
import 'package:olx/View/Anuncios.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1fa2)
);

void main() {
  runApp(MaterialApp(
    title: "Olx",
    home: Anuncios(),
    theme: temaPadrao,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
