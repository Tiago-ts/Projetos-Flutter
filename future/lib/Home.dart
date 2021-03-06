import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String _preco = "0";

  Future<Map> _RecuperarPreco() async{

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    return json.decode(response.body);


  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map>(

      future: _RecuperarPreco(),
      builder: (context, snapshot){

        String resultado;

        switch(snapshot.connectionState){

          case ConnectionState.done:
            if(snapshot.hasError){
              resultado = "Erro ao carregar os dados";
            } else {
              double valor = snapshot.data["BRL"]["buy"];
              resultado = "R\$ " + valor.toString();
            }
            break;

          case ConnectionState.waiting:
            resultado = "Carregando..";
            break;

          case ConnectionState.none:
            break;

          case ConnectionState.active:
            break;
        }
        return Scaffold(

          body: Container(

            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("imagens/bitcoin.png"),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                       resultado,
                      style: TextStyle(
                          fontSize: 35
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "Atualizar",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    color: Colors.orange,
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    onPressed: _RecuperarPreco,

                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

/*Scaffold(

      body: Container(

        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + _preco,
                  style: TextStyle(
                      fontSize: 35
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: _RecuperarPreco,

              )
            ],
          ),
        ),
      ),
    );*/
