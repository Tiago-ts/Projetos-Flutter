
class Usuario {

  String _idUsuario;
  String _nome;
  String _email;
  String _senha;
  String _endereco;
  String _cidade;

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String _tipoUsuario;
  String _tipoSangue;
  String _dataNascimento;


  String get tipoSangue => _tipoSangue;

  set tipoSangue(String value) {
    _tipoSangue = value;
  }

  double _latitude;
  double _longitude;

  Usuario();

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {

      "idUsuario"   : this.idUsuario,
      "nome"        : this.nome,
      "email"       : this.email,
      "endereco"    : this.endereco,
      "cidade"      : this.cidade,
      "tipoSangue"  : this.tipoSangue,
      "dataNascimento": this._dataNascimento,
      "tipoUsuario" : this.tipoUsuario,
      "latitude"    : this.latitude,
      "longitude"   : this.longitude,
    };

    return map;

  }

  String verificaTipoUsuario(bool tipoUsuario){

    return tipoUsuario  ? "doador" : "hemocentro";

  }

  String get tipoUsuario => _tipoUsuario;

  set tipoUsuario(String value) {
    _tipoUsuario = value;
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

  String get dataNascimento => _dataNascimento;

  set dataNascimento(String value) {
    _dataNascimento = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }


}