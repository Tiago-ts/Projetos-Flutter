import 'package:flutter/material.dart';
import 'package:cara_ou_coroa/Resultado.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  void _exibirResultado(){

    var item = ["cara", "coroa"];
    var numero = Random().nextInt(item.length);

    print(numero);

    var resultado = item[numero];

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Resultado(resultado))
    );
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff61bd86),
      //backgroundColor: Color(0xffffcc80),
      //backgroundColor: Color.fromRGBO(255, 204, 128, 0.8),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("imagens/logo.png"),
            GestureDetector(
              onTap: _exibirResultado,
              child: Image.asset("imagens/botao_jogar.png"),
            )
          ],
        ),

      ),
    );
  }
}
