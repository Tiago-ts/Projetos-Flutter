
class Usuario {

  String _idUsuario;
  String _nome;
  String _email;
  String _senha;
  String _endereco;
  String _rua;
  String _numero;

  String _bairro;
  String _cidade;
  String _estado;

  String _tipoUsuario;
  String _tipoSangue;
  //String _dataNascimento;

  double _latitude;
  double _longitude;

  Usuario();


  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {

      "idUsuario"   : this.idUsuario,
      "nome"        : this.nome,
      "email"       : this.email,
      "senha"       : this.senha,
      "endereco"    : this.endereco,
      "rua"         : this.rua,
      "numero"      : this.numero,
      "bairro"      : this.bairro,
      "cidade"      : this.cidade,
      "estado"      : this.estado,
      "tipoSangue"  : this.tipoSangue,
     // "dataNascimento": this.dataNascimento,
      "tipoUsuario" : this.tipoUsuario,
      "latitude"    : this.latitude,
      "longitude"   : this.longitude,
    };

    return map;

  }

  String verificaTipoUsuario(bool tipoUsuario){

    return tipoUsuario  ? "doador" : "hemocentro";

  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  String get tipoUsuario => _tipoUsuario;

  set tipoUsuario(String value) {
    _tipoUsuario = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }



  String get tipoSangue => _tipoSangue;

  set tipoSangue(String value) {
    _tipoSangue = value;
  }


  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }
/*
  String get dataNascimento => _dataNascimento;

  set dataNascimento(String value) {
    _dataNascimento = value;
  }
  */

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }


}