import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: home(),
    debugShowCheckedModeBanner: false,
  ));

  
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: Text("Frases do dia"),
        backgroundColor: Colors.green,
      ),
      body: container(),
    );
  }
}
