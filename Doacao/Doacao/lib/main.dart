import 'package:Doacao/telas/Home.dart';
import 'package:flutter/material.dart';
import 'Rotas.dart';
import 'Splash.dart';
import 'Welcome.dart';

final ThemeData temaPadrao = ThemeData(
    primaryColor: Color(0xff000000),
    accentColor: Color(0xff546e7a)
);

void main() => runApp(MaterialApp(
  title: "Doação",
  home: Splash(),
  //home: Welcome(),
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: Rotas.gerarRotas,
  debugShowCheckedModeBanner: false,
));
