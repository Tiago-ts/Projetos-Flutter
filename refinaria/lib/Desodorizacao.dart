import 'package:flutter/material.dart';

class Desodorizacao extends StatefulWidget {
  @override
  _DesodorizacaoState createState() => _DesodorizacaoState();
}

class _DesodorizacaoState extends State<Desodorizacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Desodorização"),
          backgroundColor: Colors.blueAccent,
        ),


        body: Center(
          child: Container(
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Calcule sua produção",
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            fontSize: 25,
                            fontWeight: FontWeight.bold

                        ),
                      ),
                    ),


                    TextField(

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Quanto foi sua produção?",

                      ),
                      style: TextStyle(
                          color: Colors.black,

                          fontSize: 22
                      ),

                    ),

                    Padding(padding: EdgeInsets.only(top: 20),
                      child: Text("texto2" ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Padding(

                      padding: EdgeInsets.only(top: 20),

                      child: RaisedButton(

                          color: Colors.blue,
                          textColor: Colors.white,

                          padding: EdgeInsets.all(15),
                          child: Text(

                            "Calcular",
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                          onPressed: (){}
                      ),

                    ),
                    Padding(padding: EdgeInsets.only(top: 30),
                      child: Text("texto1" ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                  ],
                ),
              )
          ),
        )
    );
  }
}

