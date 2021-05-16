
class Destino {

  String _rua;
  String _numero;
  String _cidade;
  String _estado;
  String _bairro;
  String _cep;

  String _tipoSanguineo;

  double _latitude;
  double _longitude;

  Destino();

  String get tipoSanguineo => _tipoSanguineo;

  set tipoSanguineo(String value) {
    _tipoSanguineo = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }


  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }




}