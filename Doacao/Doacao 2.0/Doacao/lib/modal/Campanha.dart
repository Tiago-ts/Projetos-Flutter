
import 'package:cloud_firestore/cloud_firestore.dart';

class Campanha{

  String _id;
  String _estado;
  String _titulo;
  String _telefone;
  String _descricao;
  String _tipoSangue;

  List<String> _fotos;

  Campanha();

  Campanha.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.documentID;
    this.estado = documentSnapshot["estado"];
    this.titulo     = documentSnapshot["titulo"];
    this.telefone   = documentSnapshot["telefone"];
    this.descricao  = documentSnapshot["descricao"];
    this.tipoSangue  = documentSnapshot["tipoSangue"];

    this.fotos  = List<String>.from(documentSnapshot["fotos"]);

  }

  Campanha.gerarId(){

    Firestore db = Firestore.instance;
    CollectionReference Campanhas = db.collection("meus_anuncios");
    this.id = Campanhas.document().documentID;

    this.fotos = [];

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "id"        : this.id,
      "estado"    : this.estado,
      "titulo"    : this.titulo,
      "telefone"  : this.telefone,
      "descricao" : this.descricao,
      "tiposangue" : this.tipoSangue,
      "fotos"     : this.fotos,
    };

    return map;

  }

  List<String> get fotos => _fotos;

  set fotos(List<String> value) {
    _fotos = value;
  }

  String get tipoSangue => _tipoSangue;

  set tipoSangue(String value) {
    _tipoSangue = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


}