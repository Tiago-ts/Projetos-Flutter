import 'package:flutter/material.dart';

class jogo extends StatefulWidget {
  @override
  _jogoState createState() => _jogoState();
}

class _jogoState extends State<jogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo",
          style: TextStyle(

              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
          ),

        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),

            ),
          ),

          Image.asset("imagens/padrao.png"),

          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha uma Opção Abaixo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
              ),

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset("imagens/pedra.png", height: 99,),
              Image.asset("imagens/papel.png" , height: 99,),
              Image.asset("imagens/tesoura.png" , height: 99,),

            ],
          )

        ],
      ),
    );
  }
}
