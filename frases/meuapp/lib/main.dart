import 'package:flutter/material.dart';
import 'dart:math';

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

  var _frases = [

    "As pessoa não mudam quando chegam ao poder, elas se revelam!",
    "Mantenha-se focado mesmo que as pessoas que você ama, estejam em outra sintonia.",
    "Quando é para acontecer, até quem tenta te atrapalhar ajuda.",
    "Não se distraia quando deveria estar focado, algumas distrações podem lhe custar caro.",
    "Homens assumem os próprios erros, covardes procuram em quem por a culpa.",
    "Não importa o quão leal você seja. Esteja preparado para a deslealdade dos outros."

  ];

  var _frasesGeradas = "Clique abaixo para gerar uma Frase!";

  void _gerarFrase(){

    var numeroSorteado = Random().nextInt(_frases.length);

    setState(() {
      _frasesGeradas = _frases[numeroSorteado];
    });
    print(numeroSorteado);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do Dia"),
        backgroundColor: Colors.green,
      ),


      body: Center(
        child: Container(
        //width: double.infinity,
        
        padding: EdgeInsets.all(16),
       /* decoration: BoxDecoration(
          border: Border.all(width:3, color: Colors.red)
        ),*/


        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            Image.asset("imagens/logo.png"),
            Text(
              _frasesGeradas,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
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
              onPressed: _gerarFrase,
            )
          ]
        ),


      ),
      )


    );
  }
}
