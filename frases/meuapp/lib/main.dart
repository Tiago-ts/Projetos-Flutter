import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,

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
        title: Text("Frases do Dia"),
        backgroundColor: Colors.green,
      ),


      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(width:3, color: Colors.red)
        ),


        child: Column(
          children:<Widget>[
            Image.asset("imagens/logo.png"),
            Text(
              "Clique abaixo para gerar uma frase!",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17,
                fontStyle: FontStyle.italic,
                color: Colors.black
              ),
            ),

            RaisedButton(
              child: Text(
                "Nova frase",
               style: TextStyle(
                fontSize:17,
                color: Colors.white,
                 fontWeight: FontWeight.bold,

              ),),
             
              color: Colors.green,
              onPressed: (){},
            )
          ]
        ),


      ),


    );
  }
}
