import 'dart:ui';

import 'package:flutter/material.dart';

class Interesterificacao extends StatefulWidget {
  @override
  _InteresterificacaoState createState() => _InteresterificacaoState();
}

class _InteresterificacaoState extends State<Interesterificacao> {

  TextEditingController _producao = TextEditingController();

  String _Resultado = " ";
  String _erro = " ";
  double _total = 0;

  void _limpar(){
    _producao.text= "";
  }



  void _calcular() {
    double valor = double.tryParse(_producao.text);


    if (valor == null || valor <= 0) {
      print("Digite um número maior que zero ");

      setState(() {
        _erro = "Digite um número maior que zero ";
        _Resultado = " ";
      });
    } else {
      if (valor >= 48000) {
        setState(() {
          _erro = " ";
          _Resultado = " Não houve parada de produção";
        });
      } else {
        _total = valor * 480 / 48000;
        _total = 480 - _total;
        var numero = _total.ceil();

        setState(() {
          _erro = " ";
          // ignore: undefined_getter
          _Resultado =
              " Sua parada de produção foi " +  numero.toString() +" minutos ";
        });
      }
    }

    _limpar();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Interesterificação"),
          backgroundColor: Color(0xFFf45d27),
        ),


        body: Center(
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Calcule sua parada de produção",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 65,
                          padding: EdgeInsets.only(
                              top: 0, left: 20, right: 16, bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 5
                                )
                              ]

                          ),

                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Quanto foi sua produção?",
                                icon: Icon(Icons.invert_colors,
                                  color: Colors.grey,
                                )
                            ),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            controller: _producao,
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 15),
                    child: Text(_Resultado ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(top:0, left: 0, right: 0, bottom: 15),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 5),

                          child: Text(
                            _erro ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  RaisedButton(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          fontSize:23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      color: Color(0xFFf5851f),

                      onPressed: _calcular,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                      )
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}