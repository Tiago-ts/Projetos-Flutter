import 'package:Doacao/modal/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UsuarioFirebase {

  static Future<FirebaseUser> getUsuarioAtual() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser();

  }

  static Future<Usuario> getDadosUsuarioLogado() async {

    FirebaseUser firebaseUser = await getUsuarioAtual();
    String idUsuario = firebaseUser.uid;

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("usuarios")
        .document( idUsuario )
        .get();

    Map<String, dynamic> dados = snapshot.data;

    String tipoUsuario = dados["tipoUsuario"];
    String email = dados["email"];
    String nome = dados["nome"];
    String tipoSangue = dados["tipoSangue"];

    Usuario usuario = Usuario();

    usuario.idUsuario = idUsuario;
    usuario.tipoUsuario = tipoUsuario;
    usuario.email = email;
    usuario.nome = nome;
    usuario.tipoSangue = tipoSangue;

    return usuario;

  }

  static atualizarDadosLocalizacao(String idRequisicao, double lat, double lon) async {

    Firestore db = Firestore.instance;

    Usuario doador = await getDadosUsuarioLogado();
    doador.latitude = lat;
    doador.longitude = lon;

    db.collection("requisicoes")
        .document( idRequisicao )
        .updateData({
      "doador" : doador.toMap()
    });

  }

}