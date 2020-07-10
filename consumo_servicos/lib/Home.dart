import 'package:flutter/material.dart';
import 'package:consumo_servicos/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPost(){

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("conumo de serviços"),
      ),
      body: FutureBuilder<Map>(

          future: null,
          builder: (context, snapshot){


            switch(snapshot.connectionState){

              case ConnectionState.done:
                if(snapshot.hasError){

                } else {

                }

                break;

              case ConnectionState.waiting:

                break;

              case ConnectionState.none:
                break;

              case ConnectionState.active:
                break;
            }

            return Center(
              child: Text(""),
            );

          },
      ),
    );
  }
}


