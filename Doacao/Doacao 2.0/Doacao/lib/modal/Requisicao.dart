import 'package:Doacao/modal/Usuario.dart';
import 'package:Doacao/modal/Destino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Requisicao {

  String _id;
  String _status;
  Usuario _hemocentro;
  Usuario _doador;
  Destino _destino;
  String _tipoSanguineo;

  Requisicao(){

    Firestore db = Firestore.instance;

    DocumentReference ref = db.collection("requisicoes").document();
    this.id = ref.documentID;

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> dadosHemocentro = {

      "id" : this._hemocentro.idUsuario,
      "nome" : this.hemocentro.nome,
      "email" : this.hemocentro.email,
      "tipoUsuario" : this.hemocentro.tipoUsuario,
      "idUsuario" : this.hemocentro.idUsuario,
      "latitude" : this.hemocentro.latitude,
      "longitude" : this.hemocentro.longitude,
    };

    Map<String, dynamic> dadosDestino = {

      "id" : this.id,
      "rua" : this.destino.rua,
      "numero" : this.destino.numero,
      "bairro" : this.destino.bairro,
      "estado" : this.destino.estado,
      "cep" : this.destino.cep,
      "latitude" : this.destino.latitude,
      "longitude" : this.destino.longitude,
      "tipoSanguineo" : this.destino.tipoSanguineo,
    };

    Map<String, dynamic> dadosRequisicao = {

      "id" : this.id,
      "status" : this.status,
      "hemocentro" : dadosHemocentro,
      "doador" : null,
      "destino" : dadosDestino,
    };

    return dadosRequisicao;

  }


  String get tipoSanguineo => _tipoSanguineo;

  set tipoSanguineo(String value) {
    _tipoSanguineo = value;
  }


  Destino get destino => _destino;

  set destino(Destino value) {
    _destino = value;
  }

  Usuario get doador => _doador;

  set doador(Usuario value) {
    _doador = value;
  }

  Usuario get hemocentro => _hemocentro;

  set hemocentro(Usuario value) {
    _hemocentro = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}