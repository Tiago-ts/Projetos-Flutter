import 'package:flutter/material.dart';

class Campanhas extends StatefulWidget {
  @override
  _CampanhasState createState() => _CampanhasState();
}

class _CampanhasState extends State<Campanhas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(50),
                child:  Text("Campanhas"),

              ),
            ],
          ),
        ),
      ),

    );
  }
}