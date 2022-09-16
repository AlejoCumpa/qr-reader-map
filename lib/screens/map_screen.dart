import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_map_web_reader/providers/db_provider.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => MapaScreenState();
}

class MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    //Marcadores
    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scan.getLatLng(), zoom: 17, tilt: 50)));
              },
              icon: const Icon(Icons.location_on_outlined))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.hybrid;
            } else {
              mapType = MapType.normal;
            }
          });
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
