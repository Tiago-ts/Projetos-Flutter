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
        // centerTitle: true,
        title: Text("Campanhas"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromRGBO(223, 51, 56, 25),
                    Color.fromRGBO(234, 85, 63, 25)
                  ])
          ),
        ),
      ),


      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Padding(

                padding: EdgeInsets.all(50),
                child:  Text(
                    "Campanhas"

                ),



              ),
            ],
          ),
        ),
      ),
    );
  }
}