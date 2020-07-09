import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemBuilder: null
        ),
      ),

    );
  }
}
