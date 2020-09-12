import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:refinaria/Desodorizacao.dart';
import 'package:refinaria/Hidrogenacao.dart';
import 'package:refinaria/Interesterificacao.dart';
import 'package:refinaria/Neutra.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),

  ));

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

          child: Column(
            children: <Widget>[


              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFf45d27),
                      Color(0xFFf5851f)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90)
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                       child: Icon(Icons.invert_colors,
                          size: 80,
                          color: Colors.white,
                    ),
                    ),
                    Align(
                      child: Text(
                          "Óleos e Gorduras",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 18),

                width: MediaQuery.of(context).size.width/1.15,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color(0xFFf45d27),
                          Color(0xFFf5851f)
                        ]
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,

                      )
                    ]
                ),

                child: Center(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      RaisedButton(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Desodorização",
                            style: TextStyle(
                              fontSize:23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,


                            ),
                          ),
                          color: Color(0xFFf5851f),


                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Desodorizacao()
                                )
                            );
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))
                      ),


                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14),

                width: MediaQuery.of(context).size.width/1.15,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color(0xFFf45d27),
                          Color(0xFFf5851f)
                        ]
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,

                      )
                    ]
                ),

                child: Center(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      RaisedButton(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Hidrogenação",
                            style: TextStyle(
                              fontSize:23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,


                            ),
                          ),
                          color: Color(0xFFf5851f),


                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hidrogenacao()
                                )
                            );
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))
                      ),


                    ],
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 14),

                width: MediaQuery.of(context).size.width/1.15,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color(0xFFf45d27),
                          Color(0xFFf5851f)
                        ]
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,

                      )
                    ]
                ),

                child: Center(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      RaisedButton(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Interesterificação",
                            style: TextStyle(
                              fontSize:23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,


                            ),
                          ),
                          color: Color(0xFFf5851f),


                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Interesterificacao()
                                )
                            );
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))
                      ),


                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 14),

                width: MediaQuery.of(context).size.width/1.15,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color(0xFFf45d27),
                          Color(0xFFf5851f)
                        ]
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,

                      )
                    ]
                ),

                child: Center(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      RaisedButton(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Neutralização e Branqueamento",
                            style: TextStyle(
                              fontSize:23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,


                            ),
                          ),
                          color: Color(0xFFf5851f),


                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Neutra()
                                )
                            );
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))
                      ),

                    ],

                  ),

                ),

              ),

            ],
          ),
        ),
        //continua
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFf5851f),

            onPressed: (){},

            tooltip: 'Increment',


            child: Icon(Icons.add),

      ),
    );
  }
}
