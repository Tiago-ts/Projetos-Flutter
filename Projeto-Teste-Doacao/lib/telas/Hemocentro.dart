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
import 'Lista.dart';

class Hemocentro extends StatefulWidget {
  @override
  _HemocentroState createState() => _HemocentroState();
}

class _HemocentroState extends State<Hemocentro> {

  //TextEditingController _controllerDestino = TextEditingController
  //  (text: "R. Heitor Penteado, 800");

  //TextEditingController _controllerDestino = TextEditingController();

  _recuperarDestino(String idUsuario) async {


  }

  _verificarUsuario() async{


  }

  String _tipoSangue;

  List<String> itensMenu = ["Configurações", "Editar perfil","Requisições", "Deslogar" ];

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _posicaoCamera =

      CameraPosition(target: LatLng(-23.563999, -46.653256),
                   //   zoom: 19
      );

  Set<Marker> _marcadores = {};

  String _idRequisicao;

  Position _localHemocentro;

  Map<String, dynamic> _dadosRequisicao;

  StreamSubscription<DocumentSnapshot> _streamSubscriptionRequisicoes;

  //Controles para exibição na tela

  bool _exibirCaixaEnderecoDestino = true;
  String _textoBotao = "Chamar Doador";
  Color _corBotao = Color(0xff309223);
  Function _funcaoBotao;



  _chamarDoador() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    if ( usuarioLogado != null) {

      String idUsuario = usuarioLogado.uid;

      Firestore banco = Firestore.instance;
      DocumentSnapshot snapshot = await banco.collection("usuarios")
          .document(idUsuario)
          .get();

      Map<String, dynamic> dados = snapshot.data;

      String endereco = dados["endereco"];
      String cidade = dados["cidade"];

      print( "resultadoteste endereco " + endereco);
      print( "resultadoteste cidade " + cidade);

      TextEditingController _controllerDestino = TextEditingController
        (text: endereco + ","+ cidade );


    String enderecoDestino = _controllerDestino.text;

    if (enderecoDestino.isNotEmpty) {
      List<Placemark> listaEnderecos =
      await Geolocator().placemarkFromAddress(enderecoDestino);

      if (listaEnderecos != null && listaEnderecos.length > 0) {

        Placemark endereco = listaEnderecos[0];

        Destino destino = Destino();


        destino.estado = endereco.administrativeArea;
        destino.cep = endereco.postalCode;
        destino.bairro = endereco.subLocality;
        destino.cidade = endereco.locality;
        destino.rua = endereco.thoroughfare;
        destino.numero = endereco.subThoroughfare;

        destino.tipoSanguineo = _tipoSangue;

        destino.latitude = endereco.position.latitude;
        destino.longitude = endereco.position.longitude;

        String enderecoConfirmacao;

        enderecoConfirmacao = "\n Tipo de sangue: " + _tipoSangue;
        enderecoConfirmacao += "\n Rua: " + destino.rua + ", " + destino.numero;
        enderecoConfirmacao += "\n Bairro: " + destino.bairro;
        enderecoConfirmacao += "\n Cidade: " + destino.cidade;
        enderecoConfirmacao += "\n Estado: " + destino.estado;
        enderecoConfirmacao += "\n Cep: " + destino.cep;

        showDialog(
            context: context,
            builder: (contex) {
              return AlertDialog(
                title: Text("Confirmar doação"),
                // content: Text(_tipoSangue),
                content: Text(enderecoConfirmacao),
                contentPadding: EdgeInsets.all(16),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(contex),
                  ),
                  FlatButton(
                    child: Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      //salvar requisicao
                      _salvarRequisicao(destino);

                      Navigator.pop(contex);
                    },
                  )
                ],
              );
            });
      }
    }
    }

  }

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

      case "Requisições":
        Navigator.push(context, MaterialPageRoute(builder: (context) => Lista()));
        break;
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _adicionarListenerLocalizacao() {

    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10);

    geolocator.getPositionStream(locationOptions).listen((Position position) {
      if (_idRequisicao != null && _idRequisicao.isNotEmpty) {

        //Atualizar local do Hemocentro

        UsuarioFirebase.atualizarDadosLocalizacao(
            _idRequisicao, position.latitude, position.longitude);
      } else {
        setState(() {
          _localHemocentro = position;
        });
        _statusDoadorNaoChamado();
      }
    });
  }

  _recuperaUltimaLocalizacaoConhecida() async {

    Position position = await Geolocator().getLastKnownPosition(
      //  desiredAccuracy: LocationAccuracy.best);
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    setState(() {
      if (position != null) {
        _exibirMarcadorHemocentro(position);

        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17);
        _localHemocentro = position;
        _movimentarCamera(_posicaoCamera);
      }
    });
  }

  _movimentarCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _exibirMarcadorHemocentro(Position local) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            "imagens/hemocentro.png")
        .then((BitmapDescriptor icone) {
      Marker marcadorHemocentro = Marker(
          markerId: MarkerId("marcador-hemocentro"),
          position: LatLng(local.latitude, local.longitude),
          infoWindow: InfoWindow(title: "Meu local"),
          icon: icone);

      setState(() {
        _marcadores.add(marcadorHemocentro);
      });
    });
  }



  _salvarRequisicao(Destino destino) async {


    Usuario hemocentro = await UsuarioFirebase.getDadosUsuarioLogado();

    hemocentro.latitude = _localHemocentro.latitude;
    hemocentro.longitude = _localHemocentro.longitude;

    Requisicao requisicao = Requisicao();
    requisicao.destino = destino;
    requisicao.hemocentro = hemocentro;
    requisicao.status = StatusRequisicao.AGUARDANDO;

    Firestore db = Firestore.instance;

    //salvar requisição
    db
        .collection("requisicoes")
        .document(requisicao.id)
        .setData(requisicao.toMap());

    //Salvar requisição ativa
    Map<String, dynamic> dadosRequisicaoAtiva = {};
    dadosRequisicaoAtiva["id_requisicao"] = requisicao.id;
    dadosRequisicaoAtiva["id_usuario"] = hemocentro.idUsuario;
    dadosRequisicaoAtiva["status"] = StatusRequisicao.AGUARDANDO;

    db
        .collection("requisicao_ativa")
        .document(hemocentro.idUsuario)
        .setData(dadosRequisicaoAtiva);

    //Adicionar listener requisicao
    if (_streamSubscriptionRequisicoes == null) {
      _adicionarListenerRequisicao(requisicao.id);
    }
  }

  _alterarBotaoPrincipal(String texto, Color cor, Function funcao) {
    setState(() {
      _textoBotao = texto;
      _corBotao = cor;
      _funcaoBotao = funcao;
    });
  }

  _statusDoadorNaoChamado() {
    _exibirCaixaEnderecoDestino = true;

    _alterarBotaoPrincipal("Chamar doador", Color(0xffba1212), () {
      _chamarDoador();
    });

    if (_localHemocentro != null) {
      Position position = Position(
          latitude: _localHemocentro.latitude,
          longitude: _localHemocentro.longitude);
      _exibirMarcadorHemocentro(position);
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19);
      _movimentarCamera(cameraPosition);
    }
  }

  _statusAguardando() {

    _exibirCaixaEnderecoDestino = false;

    //Desativar chamado do doador desabilitado
    /*

    _alterarBotaoPrincipal("Cancelar", Colors.red, () {
      _cancelarDoacao();
    });

    */

    double hemocentroLat = _dadosRequisicao["hemocentro"]["latitude"];
    double hemocentroLon = _dadosRequisicao["hemocentro"]["longitude"];
    Position position =
        Position(latitude: hemocentroLat, longitude: hemocentroLon);
    _exibirMarcadorHemocentro(position);
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17
              );

    _movimentarCamera(cameraPosition);


  }

  _statusACaminho() {
    _exibirCaixaEnderecoDestino = false;

   // _alterarBotaoPrincipal("Doador a caminho", Colors.grey, () {});

    double latitudeDestino = _dadosRequisicao["hemocentro"]["latitude"];
    double longitudeDestino = _dadosRequisicao["hemocentro"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["doador"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["doador"]["longitude"];


    // alterado para doador era hemocentro
    Marcador marcadorOrigem = Marcador(LatLng(latitudeOrigem, longitudeOrigem),
        "imagens/doador.png", "Local doador");



    Marcador marcadorDestino = Marcador(
        LatLng(latitudeDestino, longitudeDestino),
        "imagens/hemocentro.png",
        "Local destino");

    _exibirCentralizarDoisMarcadores(marcadorOrigem, marcadorDestino);
  }

  _statusEmViagem() {

    _exibirCaixaEnderecoDestino = false;
    //_alterarBotaoPrincipal("Em viagem", Colors.grey, null);

    double latitudeDestino = _dadosRequisicao["destino"]["latitude"];
    double longitudeDestino = _dadosRequisicao["destino"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["doador"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["doador"]["longitude"];

    Marcador marcadorOrigem = Marcador(LatLng(latitudeOrigem, longitudeOrigem),
        "imagens/doador.png", "Local doador");

    Marcador marcadorDestino = Marcador(
        LatLng(latitudeDestino, longitudeDestino),
        "imagens/hemocentro.png",
        "Local destino");

    _exibirCentralizarDoisMarcadores(marcadorOrigem, marcadorDestino);
  }

  _exibirCentralizarDoisMarcadores(

      Marcador marcadorOrigem, Marcador marcadorDestino) {
    double latitudeOrigem = marcadorOrigem.local.latitude;
    double longitudeOrigem = marcadorOrigem.local.longitude;

    double latitudeDestino = marcadorDestino.local.latitude;
    double longitudeDestino = marcadorDestino.local.longitude;

    //Exibir dois marcadores
    _exibirDoisMarcadores(marcadorOrigem, marcadorDestino);

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

  _statusFinalizada() async {

    double latitudeDestino = _dadosRequisicao["destino"]["latitude"];
    double longitudeDestino = _dadosRequisicao["destino"]["longitude"];

    double latitudeOrigem = _dadosRequisicao["origem"]["latitude"];
    double longitudeOrigem = _dadosRequisicao["origem"]["longitude"];

    double distanciaEmMetros = await Geolocator().distanceBetween(
        latitudeOrigem, longitudeOrigem, latitudeDestino, longitudeDestino);

    //_alterarBotaoPrincipal("Doação concluida!", Colors.green, () {});

    _marcadores = {};
    Position position =
        Position(latitude: latitudeDestino, longitude: longitudeDestino);
    _exibirMarcador(position, "imagens/hemocentro.png", "Destino");

    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 17);

    _movimentarCamera(cameraPosition);
  }

  _statusConfirmada() {
    if (_streamSubscriptionRequisicoes != null)
      _streamSubscriptionRequisicoes.cancel();

    _exibirCaixaEnderecoDestino = true;
    _alterarBotaoPrincipal("Chamar Doador", Color(0xffba1212), () {
      _chamarDoador();
    });

    _dadosRequisicao = {};
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

  _movimentarCameraBounds(LatLngBounds latLngBounds) async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 100));
  }

  _exibirDoisMarcadores(Marcador marcadorOrigem, Marcador marcadorDestino) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    LatLng latLngOrigem = marcadorOrigem.local;
    LatLng latLngDestino = marcadorDestino.local;

    Set<Marker> _listaMarcadores = {};
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            marcadorOrigem.caminhoImagem)
        .then((BitmapDescriptor icone) {
      Marker mOrigem = Marker(
          markerId: MarkerId(marcadorOrigem.caminhoImagem),
          position: LatLng(latLngOrigem.latitude, latLngOrigem.longitude),
          infoWindow: InfoWindow(title: marcadorOrigem.titulo),
          icon: icone);
      _listaMarcadores.add(mOrigem);
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: pixelRatio),
            marcadorDestino.caminhoImagem)
        .then((BitmapDescriptor icone) {
      Marker mDestino = Marker(
          markerId: MarkerId(marcadorDestino.caminhoImagem),
          position: LatLng(latLngDestino.latitude, latLngDestino.longitude),
          infoWindow: InfoWindow(title: marcadorDestino.titulo),
          icon: icone);
      _listaMarcadores.add(mDestino);
    });

    setState(() {
      _marcadores = _listaMarcadores;
    });
  }

  _cancelarDoacao() async {
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();

    Firestore db = Firestore.instance;
    db
        .collection("requisicoes")
        .document(_idRequisicao)
        .updateData({"status": StatusRequisicao.CANCELADA}).then((_) {
      db.collection("requisicao_ativa").document(firebaseUser.uid).delete();
    });
  }

  _recuperaRequisicaoAtiva() async {
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();

    Firestore db = Firestore.instance;
    DocumentSnapshot documentSnapshot = await db
        .collection("requisicao_ativa")
        .document(firebaseUser.uid)
        .get();

    if (documentSnapshot.data != null) {
      Map<String, dynamic> dados = documentSnapshot.data;
      _idRequisicao = dados["id_requisicao"];
      _adicionarListenerRequisicao(_idRequisicao);
    } else {
      _statusDoadorNaoChamado();
    }
  }

  _adicionarListenerRequisicao(String idRequisicao) async {
    Firestore db = Firestore.instance;
    _streamSubscriptionRequisicoes = await db
        .collection("requisicoes")
        .document(idRequisicao)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data != null) {
        Map<String, dynamic> dados = snapshot.data;
        _dadosRequisicao = dados;
        String status = dados["status"];
        _idRequisicao = dados["id_requisicao"];

        switch (status) {
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

  @override
  void initState() {
    super.initState();

    //chamar localização do usuário
    _recuperaUltimaLocalizacaoConhecida();

   // _verificarUsuario();

    //adicionar listener para requisicao ativa
    _recuperaRequisicaoAtiva();

    //_recuperaUltimaLocalizacaoConhecida();
    _adicionarListenerLocalizacao();
  }


  @override
  void dispose() {
    super.dispose();
    _streamSubscriptionRequisicoes.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Hemocentro "),
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
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              //Mapas na telaa

              //mapType: MapType.satellite,
              mapType: MapType.normal,
              initialCameraPosition: _posicaoCamera,
              onMapCreated: _onMapCreated,
              //myLocationEnabled: true,
              myLocationButtonEnabled: false,
              //myLocationButtonEnabled: true,
              markers: _marcadores,
              //-23,559200, -46,658878
            ),

            Visibility(
              visible: _exibirCaixaEnderecoDestino,
              child: Stack(
                children: <Widget>[
                  /*
                  Positioned(
                    top: 0,
                    left: 130,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white),

                        child: TextField(
                         // textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                              icon: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15),
                                width: 10,
                                height: 25,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                              ),

                              hintStyle: TextStyle(fontSize: 17,color: Color(0xff000000) ),
                              hintText: "Meu local ",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 5, bottom: 10, top: 18)),
                        ),
                      ),
                    ),
                  ),  */

                  Positioned(
                    top: -15,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                            children: [

                              RadioListTile(
                                  title: Text("AB+",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "AB+",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado " + valor  );

                                    });
                                  }
                              ),

                              RadioListTile(
                                  title: Text("AB-",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "AB-",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado " + valor  );

                                    });
                                  }
                              ),

                              RadioListTile(
                                title: Text("A+",
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                  value: "A+",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado  " + valor );

                                    });
                                  }
                              ),

                              RadioListTile(
                                  title: Text("A-",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "A-",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado "  + valor );

                                    });
                                  }
                              ),


                              RadioListTile(
                                  title: Text("B+",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "B+",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado  " + valor  );

                                    });
                                  }
                              ),

                              RadioListTile(
                                  title: Text("B-",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "B-",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado  " + valor  );

                                    });
                                  }
                              ),



                              RadioListTile(
                                  title: Text("O+",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "O+",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado " + valor  );

                                    });
                                  }
                              ),

                             RadioListTile(
                                  title: Text("O-",
                                    style: TextStyle(color: Colors.black, fontSize: 16),),
                                  value: "O-",
                                  groupValue: _tipoSangue,
                                  onChanged: (String valor){
                                    setState((){
                                      _tipoSangue = valor;
                                      print("resultado "  + valor );

                                    });
                                  }
                              ),

                           /* Text(_tipoSangue)*/
                            ],
                          ),
                    ),
                  ),

                ],
              ),
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: _corBotao,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed:_funcaoBotao),

              ),
            )
          ],
        ),
      ),
    );
  }

}
