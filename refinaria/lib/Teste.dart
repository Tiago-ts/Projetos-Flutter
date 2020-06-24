import 'package:flutter/material.dart';
import 'package:refinaria/Desodorizacao.dart';
import 'package:refinaria/Hidrogenacao.dart';
import 'package:refinaria/Interesterificacao.dart';

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
        appBar: AppBar(
          title: Text("Refinaria",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
            ),
          ),

          backgroundColor: Colors.blueAccent,
        ),


        body: Center(

          child: Container(

            //width: double.infinity,

            //padding: EdgeInsets.all(1),
            /* decoration: BoxDecoration(
          border: Border.all(width:3, color: Colors.red)
        ),*/

            child: Column(

              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:<Widget>[


                  Image.asset("imagens/home.jpg"),


                  RaisedButton(

                    child: Text(
                      "Desodorização",
                      style: TextStyle(
                        fontSize:23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),),

                    color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Desodorizacao()
                          )
                      );
                    },
                  ),
                  RaisedButton(

                    child: Text(
                      "Hidrogenação",
                      style: TextStyle(
                        fontSize:23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),),

                    color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Hidrogenacao()
                          )
                      );
                    },
                  ),
                  RaisedButton(

                    child: Text(
                      "Interesterificação",
                      style: TextStyle(
                        fontSize:23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),),

                    color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Interesterificacao()
                          )
                      );
                    },
                  ),
                  RaisedButton(

                    child: Text(
                      "Neutralização e Branqueamento",
                      style: TextStyle(
                        fontSize:23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),
                    ),

                    color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Desodorizacao()
                          )
                      );
                    },
                  )
                ]
            ),
          ),
        )
    );
  }
}

