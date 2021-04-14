import 'dart:async';

import 'package:Doacao/util/StatusRequisicao.dart';
import 'package:Doacao/util/UsuarioFirebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Home.dart';

class Doador extends StatefulWidget {
  @override
  _DoadorState createState() => _DoadorState();
}

class _DoadorState extends State<Doador> {


  List<String> itensMenu = ["Configurações", "Editar perfil", "Deslogar"];

  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;

  _deslogarUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  _escolhaMenuItem(String escolha) {
    switch (escolha) {
      case "Deslogar":
        _deslogarUsuario();
        break;
      case "Configurações":
        break;
    }
  }

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
      String idRequisicao = dadosRequisicao["id_requisicao"];
      Navigator.pushReplacementNamed(context, "/corrida",
          arguments: idRequisicao);
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
        title: Text("Painel Doador"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
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
                        subtitle: Text("Tipo de sangue: $tipoSanguineo  \n Endereço: $bairro, $rua, $estado"),
                          trailing: Text("Nº: $numero"),
                        onTap: () {
                          Navigator.pushNamed(context, "/corrida",
                              arguments: idRequisicao);
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
