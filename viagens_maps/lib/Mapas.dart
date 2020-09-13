import 'package:flutter/material.dart';
import 'dart:async';
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


  _onMapCreated( GoogleMapController controller){
    _controller.complete( controller);

  }

  _exibirMarcador(LatLng latLng) {
    print("Local clicado" + latLng.toString() );

    Marker marcador = Marker(
        markerId: MarkerId("marcador ${latLng.latitude}-${latLng.longitude}"),
      position: latLng,
      infoWindow: InfoWindow(
        title: "Marcador"

     )
    );

    setState(() {
      _marcadores.add(marcador);
    });
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
            initialCameraPosition: CameraPosition(
                target: LatLng(-23.562436, -46.655005),
              zoom: 16
            ),
          onMapCreated: _onMapCreated,
          onLongPress: _exibirMarcador,
        ),
      ),
    );
  }
}




Completer<GoogleMapController> _controller = Completer();
