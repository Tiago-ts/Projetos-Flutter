import 'package:flutter/material.dart';

class Resultado extends StatefulWidget {
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
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
            Image.asset("imagens/moeda_cara.png"),

            GestureDetector(
              onTap:() {
                Navigator.pop(context);
              },
              
              child: Image.asset("imagens/botao_voltar.png"),
            )
          ],
        ),

      ),
    );
  }
}
