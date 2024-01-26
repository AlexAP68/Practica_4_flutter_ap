
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

// Pantalla que muestra el mapa
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  late CameraPosition _puntInicial;
  bool isMapTypeNormal = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    _puntInicial = CameraPosition(
      //cogemos las coordenadas
      target: scan.getLatLng(),
      zoom: 17,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('id1'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        // Boton para volver
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          // Boton para volver a la posicion inicial
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(_puntInicial),
              );
            },
          ),
        ],
      ),
      body: GoogleMap(
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        // Alterna entre mapas
        mapType: isMapTypeNormal ? MapType.normal : MapType.hybrid,
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          mapController = controller;
        },
      ),
      // Boton para alternar mapas
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isMapTypeNormal = !isMapTypeNormal;
          });
        },
        child: Icon(Icons.layers),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}