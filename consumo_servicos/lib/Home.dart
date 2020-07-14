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

  Post post = Post(0, 0, "", "");

  Future<List<Post>> _recuperarPost() async{

  //  List<Post> lista = List();
  //  lista.add(post);

    http.Response response = await http.get(_urlBase + "/post");
    var dadosJson = json.decode(response.body);
    
    List<Post> postagens = List();

    for (var post in dadosJson ){
      
      print("post: " + post["title"]);
      
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
      
    }
    return postagens;


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviços"),
      ),
      
      
      body: FutureBuilder<List<Post>>(

          future: _recuperarPost(),
          builder: (context, snapshot){
            
            switch(snapshot.connectionState){

              case ConnectionState.waiting:
                return Center(
                   child: CircularProgressIndicator(),
                );
                break;

              case ConnectionState.none:
                break;

              case ConnectionState.active:
                break;

              case ConnectionState.done:
                print("conexao done");
                if(snapshot.hasError){
                  print("lista: erro ao carregar");

                } else {

                  print("lista: carregou");

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                         itemBuilder: (context, index){

                        return ListTile(
                          title: Text("teste"),
                          subtitle: Text("teste2"),
                        );
                      }
                  );
                }
                break;
            }
          },
      ),
    );
  }
}


