import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Mapas extends StatefulWidget {

  @override
  _MapasState createState() => _MapasState();
}

class _MapasState extends State<Mapas> {

  //Métodos

  Completer<GoogleMapController> _controller = Completer();

  // Marcadores

  Set<Marker> _marcadores = {};

  CameraPosition _posicaoCamera = CameraPosition(
          target: LatLng(-23.562436, -46.655005),
          zoom: 18

  );


  _onMapCreated( GoogleMapController controller){
    _controller.complete( controller);

  }

  _exibirMarcador(LatLng latLng) async {
    print("Local clicado" + latLng.toString() );

    List<Placemark> listaEnderecos = await Geolocator().placemarkFromCoordinates(
        latLng.latitude, latLng.longitude);

    if (listaEnderecos != null && listaEnderecos.length > 0 ){
      Placemark endereco = listaEnderecos[0];
      String rua = endereco.thoroughfare;

      Marker marcador = Marker(
          markerId: MarkerId("marcador ${latLng.latitude}-${latLng.longitude}"),
          position: latLng,
          infoWindow: InfoWindow(
              title: rua

          )
      );
      setState(() {
        _marcadores.add(marcador);
      });
    }

    }






  _movimentarCamera() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(_posicaoCamera)
    );
  }

  _adicionarLocalizacao() {


    var geolocator = Geolocator();

    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high);

   geolocator.getPositionStream(locationOptions).listen((Position position){
      setState(() {
        _posicaoCamera = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            //target: LatLng(-23.562436, -46.655005),
          zoom: 17
        );

        _movimentarCamera();

      });

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _adicionarLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),

      body: Container(
        child: GoogleMap(

          markers: _marcadores,

          mapType: MapType.normal,
            initialCameraPosition: _posicaoCamera,
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
        ),
      ),
    );
  }
}
