import 'package:flutter/material.dart';

class Hidrogenacao extends StatefulWidget {
  @override
  _HidrogenacaoState createState() => _HidrogenacaoState();
}

class _HidrogenacaoState extends State<Hidrogenacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidrogenação"),
        backgroundColor: Colors.blueAccent,
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(bottom: 20),
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

            ],
          ),
        ),
      ),
    );
  }
}
