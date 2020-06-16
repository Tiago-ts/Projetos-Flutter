import 'dart:math';

import 'package:flutter/material.dart';

class jogo extends StatefulWidget {
  @override
  _jogoState createState() => _jogoState();
}

class _jogoState extends State<jogo> {

  var _imagemApp = AssetImage("imagens/padrao.png");
  var _mensagem = "Escolha uma opção abaixo";
  var _msg ="Escolha uma opção abaixo";

   void _opcaoSelecionada(String escolhaUsuario){

     print("Opcao selecionada " + escolhaUsuario);

     var opcoes = ["pedra", "papel", "tesoura"];
     var numero = Random().nextInt(3);
     var escolhaApp = opcoes[numero];

     print("Escolha do App " + escolhaApp);

               //Escolha da maquina
     switch(escolhaApp){

       case "pedra":
         setState(() {
           this._imagemApp = AssetImage("imagens/pedra.png");
         });
         break;

       case "papel":
         setState(() {
           this._imagemApp = AssetImage("imagens/papel.png");
         });
         break;

       case "tesoura":
         setState(() {
           this._imagemApp = AssetImage("imagens/tesoura.png");
         });
         break;
     }

     //Selecionando o Ganhador
     //Usuario Ganhador

     if (
        (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")
     ){

       this._mensagem = "Você Ganhou!!";

       //App Ganhador
     } else if (
         (escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
         (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
         (escolhaApp == "papel" && escolhaUsuario == "pedra")
     ){
       this._mensagem = "Você Perdeu!!";

       //App empatou com usuario
     }else{
       this._mensagem = "Empatou!!";
     }
     

  }

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

          Image(image: this._imagemApp),

          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              this._mensagem,
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

              GestureDetector(
                onTap: () => _opcaoSelecionada("pedra"),
                child:Image.asset("imagens/pedra.png", height: 99,) ,
              ),
              GestureDetector(
                  onTap: () => _opcaoSelecionada("papel"),
                  child:Image.asset("imagens/papel.png", height: 99,)
              ),
              GestureDetector(
                  onTap: () => _opcaoSelecionada("tesoura"),
                  child:Image.asset("imagens/tesoura.png", height: 99,)
              ),
              /*
              Image.asset("imagens/pedra.png", height: 99,),
              Image.asset("imagens/papel.png" , height: 99,),
              Image.asset("imagens/tesoura.png" , height: 99,),
              */

            ],
          )

        ],
      ),
    );
  }
}
