import 'package:Doacao/modal/Destino.dart';
import 'package:Doacao/modal/Marcador.dart';
import 'package:Doacao/modal/Requisicao.dart';
import 'package:Doacao/modal/Usuario.dart';
import 'package:Doacao/util/StatusRequisicao.dart';
import 'package:Doacao/util/UsuarioFirebase.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:io';
import 'Home.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  List<String> itensMenu = ["Configurações", "Editar perfil", "Deslogar"];

  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;



  Stream<QuerySnapshot> _adicionarListenerRequisicoes() {
    final stream = db
        .collection("requisicoes")
        .where("status", isEqualTo: StatusRequisicao.AGUARDANDO)
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });

  }

  _recuperaRequisicaoAtivaDoador() async {

    //Recupera dados do usuario logado
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();

    //Recupera requisicao ativa
    DocumentSnapshot documentSnapshot = await db
        .collection("requisicao_ativa_Doador")
        .document(firebaseUser.uid)
        .get();

    var dadosRequisicao = documentSnapshot.data;

    if (dadosRequisicao == null) {
      _adicionarListenerRequisicoes();
    } else {

    }
  }

  @override
  void initState() {
    super.initState();

    /*
    Recupera requisicao ativa para verificar se Doador está
    atendendo alguma requisição e envia ele para tela de doacao
    */
    _recuperaRequisicaoAtivaDoador();
  }

  @override
  Widget build(BuildContext context) {
    var mensagemCarregando = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando requisições"),
          CircularProgressIndicator()
        ],
      ),
    );

    var mensagemNaoTemDados = Center(
      child: Text(
        "Não tem requisição no momento. ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Requisições"),

      ),


      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.stream,
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return mensagemCarregando;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("Erro ao carregar os dados!");
              } else {
                QuerySnapshot querySnapshot = snapshot.data;
                if (querySnapshot.documents.length == 0) {
                  return mensagemNaoTemDados;

                } else {

                  return ListView.separated(
                    itemCount: querySnapshot.documents.length,
                    separatorBuilder: (context, indice) => Divider(
                      height: 2,
                      color: Colors.grey,
                    ),

                    itemBuilder: (context, indice) {
                      List<DocumentSnapshot> requisicoes =
                      querySnapshot.documents.toList();
                      DocumentSnapshot item = requisicoes[indice];

                      String idRequisicao = item["id"];
                      String nomeHemocentro = item["hemocentro"]["nome"];
                      String rua = item["destino"]["rua"];
                      String numero = item["destino"]["numero"];
                      String bairro = item["destino"]["bairro"];
                      String estado = item["destino"]["estado"];
                      String tipoSanguineo = item["destino"]["tipoSanguineo"];

                      return ListTile(
                        title: Text(nomeHemocentro),
                        subtitle: Text("Tipo de sangue: $tipoSanguineo"
                            "  \n Endereço: $bairro, $rua, $estado"),
                        trailing: Text("Nº: $numero"),
                        onTap: () {
                        },
                      );
                    },
                  );
                }
              }
              break;
          // ignore: missing_return
          }
        },
      ),
    );
  }
}
