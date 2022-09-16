import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  late int id;
  late String tipo;
  final String valor;

  ScanModel(this.valor, {this.tipo = "", this.id = 0}) {
    if (valor.contains(('http'))) {
      tipo = 'http';
    } else {
      tipo = 'geo';
    }
  }

  LatLng getLatLng() {
    final latLng = valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final long = double.parse(latLng[1]);
    return LatLng(lat, long);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        json["valor"],
        id: json["id"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "valor": valor,
      };
}
