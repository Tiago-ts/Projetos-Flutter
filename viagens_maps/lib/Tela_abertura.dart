import 'dart:async';
import 'Home.dart';
import 'package:flutter/material.dart';

class Tela_abertura extends StatefulWidget {
  @override
  _Tela_aberturaState createState() => _Tela_aberturaState();
}

class _Tela_aberturaState extends State<Tela_abertura> {


  // SPLASH tela de abertura com tempo de 5 segundos
  //Função SPLASH

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // tempo de abertura do splash
    Timer(Duration(seconds: 3),(){

      // Chamando Tela do Home (Tela principal do App)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Home() ));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Color(0xff0066cc),
        padding: EdgeInsets.all(60),
        child: Center(
          child: Image.asset("imagens/logo.png"),
        ),
      ),
    );
  }
}
