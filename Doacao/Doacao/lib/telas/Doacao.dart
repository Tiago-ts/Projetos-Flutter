import 'package:Doacao/modal/Usuario.dart';
import 'package:Doacao/util/StatusRequisicao.dart';
import 'package:Doacao/util/UsuarioFirebase.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:io';

class Doacao extends StatefulWidget {
  String idRequisicao;

  Doacao(this.idRequisicao);

  @override
  _DoacaoState createState() => _DoacaoState();
}

class _DoacaoState extends State<Doacao> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _posicaoCamera =
      CameraPosition(target: LatLng(-23.563999, -46.653256));
  Set<Marker> _marcadores = {};
  Map<String, dynamic> _dadosRequisicao;
  String _idRequisicao;
  Position _localDoador;
  String _statusRequisicao = StatusRequisicao.AGUARDANDO;

  //Controles para exibição na tela
  String _textoBotao = "Aceitar Doação";
  Color _corBotao = Color(0xff309223);
  Function _funcaoBotao;
  String _mensagemStatus = "";

  _alterarBotaoPrincipal(String texto, Color cor, Function funcao) {
    setState(() {
      _textoBotao = texto;
      _corBotao = cor;
      _funcaoBotao = funcao;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _adicionarListenerLocalizacao() {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);

    geolocator.getPositionStream(locationOptions).listen((Position position) {
      if (position != null) {
        if (_idRequisicao != null && _idRequisicao.isNotEmpty) {
          if (_statusRequisicao != StatusRequisicao.AGUARDANDO) {
            //Atualizar local do Hemocentro
            UsuarioFirebase.atualizarDadosLocalizacao(
                _idRequisicao, position.latitude, position.longitude);
          } else {
            //aguardando
            setState(() {
              _localDoador = position;
            });
            _statusAguardando();
          }
        }
      }
    });
  }

  _recuperaUltimaLocalizacaoConhecida() async {
    Position position = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    if (position != null) {
      //Atualizar localização em tempo real do doador

    }
  }

  _movimentarCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _exibirMarcador(Position local, String icone, String infoWindow) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio), icone)
        .then((BitmapDescriptor bitmapDescriptor) {
      Marker marcador = Marker(
          markerId: MarkerId(icone),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: infoWindow),
          icon: bitmapDescriptor);

      setState(() {
        _marcadores.add(marcador);
      });
    });
  }

  _recuperarRequisicao() async {
    String idRequisicao = widget.idRequisicao;

    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot =
        await db.collection("requisicoes").document(idRequisicao).get();
  }

  _adicionarListenerRequisicao() async {
    Firestore db = Firestore.instance;

    await db
        .collection("requisicoes")
        .document(_idRequisicao)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data != null) {
        _dadosRequisicao = snapshot.data;

        Map<String, dynamic> dados = snapshot.data;
        _statusRequisicao = dados["status"];

        switch (_statusRequisicao) {
          case StatusRequisicao.AGUARDANDO:
            _statusAguardando();
            break;
          case StatusRequisicao.A_CAMINHO:
            _statusACaminho();
            break;
          case StatusRequisicao.VIAGEM:
            _statusEmViagem();
            break;
          case StatusRequisicao.FINALIZADA:
            _statusFinalizada();
            break;
          case StatusRequisicao.CONFIRMADA:
            _statusConfirmada();
            break;
        }
      }
    });
  }

  _statusAguardando() {
    _alterarBotaoPrincipal("Aceitar Doação", Color(0xff309223), () {
      _aceitarDoacao();
    });

    if (_localDoador != null) {
      double doadorLat = _localDoador.latitude;
      double doadorLon = _localDoador.longitude;

      Position position = Position(latitude: doadorLat, longitude: doadorLon);
      _exibirMarcador(position, "imagens/doador.png", "doador");

      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _movimentarCamera(cameraPosition);
    }
  }

  _statusACaminho() {
    _mensagemStatus = "A caminho do Doador";
    _alterarBotaoPrincipal("Iniciar Doação", Color(0xff309223), () {
      _iniciarDoacao();
    });

    double latitudeHemocentro = _dadosRequisicao["hemocentro"]["latitude"];
    double longitudeHemocentro = _dadosRequisicao["hemocentro"]["longitude"];

    double latitudeDoador = _dadosRequisicao["doador"]["latitude"];
    double longitudeDoador = _dadosRequisicao["doador"]["longitude"];

    //Exibir dois marcadores
    _exibirDoisMarcadores(LatLng(latitudeDoador, longitudeDoador),
        LatLng(latitudeHemocentro, longitudeHemocentro));

    //'southwest.latitude <= northeast.latitude': is not true
    var nLat, nLon, sLat, sLon;

    if (latitudeDoador <= latitudeHemocentro) {
      sLat = latitudeDoador;
      nLat = latitudeHemocentro;
    } else {
      sLat = latitudeHemocentro;
      nLat = latitudeDoador;
    }

    if (longitudeDoador <= longitudeHemocentro) {
      sLon = longitudeDoador;
      nLon = longitudeHemocentro;
    } else {
      sLon = longitudeHemocentro;
      nLon = longitudeDoador;
    }
    //-23.560925, -46.650623
    _movimentarCameraBounds(LatLngBounds(
        northeast: LatLng(nLat, nLon), //nordeste
        southwest: LatLng(sLat, sLon) //sudoeste
        ));
  }

  _finalizarDoacao() {
    Firestore db = Firestore.instance;
    db
        .collection("requisicoes")
        .document(_idRequisicao)
        .updateData({"status": StatusRequisicao.FINALIZADA});

    String idHemocentro = _dadosRequisicao["hemocentro"]["idUsuario"];
    db
        .collection("requisicao_ativa")
        .document(idHemocentro)
        .updateData({"status": StatusRequisicao.FINALIZADA});

    String idDoador = _dadosRequisicao["doador"]["idUsuario"];
    db
        .collection("doador")
        .document(idDoador)
        .updateData({"status": StatusRequisicao.FINALIZADA});
  }

  _statusFinalizada() async {
    //Calcula valor da corrida
    double latitudeDestino = _dadosRequisicao["destino"]["latitude"];
    double longitudeDestino = _dadosRequisicao["destino"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["origem"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["origem"]["longitude"];

    double distanciaEmMetros = await Geolocator().distanceBetween(
        latitudeOrigem, longitudeOrigem, latitudeDestino, longitudeDestino);



    _mensagemStatus = "Doação finalizada voçê acaba de salvar vidas!";

    _alterarBotaoPrincipal(
        "Confirmar - Doação", Color(0xff309223), () {
      _confirmarDoacao();
    });

    _mensagemStatus = "Doação finalizada";
    _alterarBotaoPrincipal(
        "Confirmar - Doação", Color(0xff309223), () {
      _confirmarDoacao();
    });

    _marcadores = {};
    Position position =
        Position(latitude: latitudeDestino, longitude: longitudeDestino);
    _exibirMarcador(position, "imagens/destino.png", "Destino");

    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 19);

    _movimentarCamera(cameraPosition);
  }

  _statusConfirmada() {
    Navigator.pushReplacementNamed(context, "/painel-doador");
  }

  _confirmarDoacao() {
    Firestore db = Firestore.instance;
    db
        .collection("requisicoes")
        .document(_idRequisicao)
        .updateData({"status": StatusRequisicao.CONFIRMADA});

    String idHemocentro = _dadosRequisicao["hemocentro"]["idUsuario"];
    db.collection("requisicao_ativa").document(idHemocentro).delete();

    String idDoador = _dadosRequisicao["doador"]["idUsuario"];
    db.collection("requisicao_ativa_doador").document(idDoador).delete();
  }

  _statusEmViagem() {
    _mensagemStatus = "Em viagem";
    _alterarBotaoPrincipal("Finalizar Doação", Color(0xffba1212), () {
      _finalizarDoacao();
    });

    double latitudeDestino = _dadosRequisicao["destino"]["latitude"];
    double longitudeDestino = _dadosRequisicao["destino"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["doador"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["doador"]["longitude"];

    //Exibir dois marcadores
    _exibirDoisMarcadores(LatLng(latitudeOrigem, longitudeOrigem),
        LatLng(latitudeDestino, longitudeDestino));

    //'southwest.latitude <= northeast.latitude': is not true
    var nLat, nLon, sLat, sLon;

    if (latitudeOrigem <= latitudeDestino) {
      sLat = latitudeOrigem;
      nLat = latitudeDestino;
    } else {
      sLat = latitudeDestino;
      nLat = latitudeOrigem;
    }

    if (longitudeOrigem <= longitudeDestino) {
      sLon = longitudeOrigem;
      nLon = longitudeDestino;
    } else {
      sLon = longitudeDestino;
      nLon = longitudeOrigem;
    }
    //-23.560925, -46.650623
    _movimentarCameraBounds(LatLngBounds(
        northeast: LatLng(nLat, nLon), //nordeste
        southwest: LatLng(sLat, sLon) //sudoeste
        ));
  }

  _iniciarDoacao() {
    Firestore db = Firestore.instance;
    db.collection("requisicoes").document(_idRequisicao).updateData({
      "origem": {
        "latitude": _dadosRequisicao["doador"]["latitude"],
        "longitude": _dadosRequisicao["doador"]["longitude"]
      },
      "status": StatusRequisicao.VIAGEM
    });

    String idHemocentro = _dadosRequisicao["hemocentro"]["idUsuario"];
    db
        .collection("requisicao_ativa")
        .document(idHemocentro)
        .updateData({"status": StatusRequisicao.VIAGEM});

    String idDoador = _dadosRequisicao["doador"]["idUsuario"];
    db
        .collection("requisicao_ativa_doador")
        .document(idDoador)
        .updateData({"status": StatusRequisicao.VIAGEM});
  }

  _movimentarCameraBounds(LatLngBounds latLngBounds) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 100));
  }

  _exibirDoisMarcadores(LatLng latLngDoador, LatLng latLngHemocentro) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    Set<Marker> _listaMarcadores = {};
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/doador.png")
        .then((BitmapDescriptor icone) {
      Marker marcador1 = Marker(
          markerId: MarkerId("marcador-doador"),
          position: LatLng(latLngDoador.latitude, latLngDoador.longitude),
          infoWindow: InfoWindow(title: "Local Doador"),
          icon: icone);
      _listaMarcadores.add(marcador1);
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/hemocentro.png")
        .then((BitmapDescriptor icone) {
      Marker marcador2 = Marker(
          markerId: MarkerId("marcador-hemocentro"),
          position:
              LatLng(latLngHemocentro.latitude, latLngHemocentro.longitude),
          infoWindow: InfoWindow(title: "Local hemocentro"),
          icon: icone);
      _listaMarcadores.add(marcador2);
    });

    setState(() {
      _marcadores = _listaMarcadores;
    });
  }

  _aceitarDoacao() async {
    //Recuperar dados do Doador
    Usuario Doador = await UsuarioFirebase.getDadosUsuarioLogado();
    Doador.latitude = _localDoador.latitude;
    Doador.longitude = _localDoador.longitude;

    Firestore db = Firestore.instance;
    String idRequisicao = _dadosRequisicao["id"];

    db.collection("requisicoes").document(idRequisicao).updateData({
      "doador": Doador.toMap(),
      "status": StatusRequisicao.A_CAMINHO,
    }).then((_) {
      //atualiza requisicao ativa
      String idHemocentro = _dadosRequisicao["hemocentro"]["idUsuario"];
      db.collection("requisicao_ativa").document(idHemocentro).updateData({
        "status": StatusRequisicao.A_CAMINHO,
      });

      //Salvar requisicao ativa para Doador
      String idDoador = Doador.idUsuario;
      db.collection("requisicao_ativa_doador").document(idDoador).setData({
        "id_requisicao": idRequisicao,
        "id_usuario": idDoador,
        "status": StatusRequisicao.A_CAMINHO,
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _idRequisicao = widget.idRequisicao;

    // adicionar listener para mudanças na requisicao
    _adicionarListenerRequisicao();

    //_recuperaUltimaLocalizacaoConhecida();
    _adicionarListenerLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel doador - " + _mensagemStatus),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              //mapa Doador

              mapType: MapType.normal,
              //mapType: MapType.satellite,
              initialCameraPosition: _posicaoCamera,
              onMapCreated: _onMapCreated,
              //myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _marcadores,
              //-23,559200, -46,658878
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Padding(
                padding: Platform.isIOS
                    ? EdgeInsets.fromLTRB(20, 10, 20, 25)
                    : EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text(
                      _textoBotao,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    color: _corBotao,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: _funcaoBotao),
              ),
            )
          ],
        ),
      ),
    );
  }
}
