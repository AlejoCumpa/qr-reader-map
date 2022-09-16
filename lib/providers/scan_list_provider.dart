import 'package:flutter/material.dart';
import 'package:qr_map_web_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionada = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;

    if (tipoSeleccionada == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scansPorTipo = await DBProvider.db.getScansByTipo(tipo);
    //print("cargarScansPorTipo: $tipo : ${scansPorTipo.length}");

    scans = [...scansPorTipo];
    tipoSeleccionada = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScanById(id);
    cargarScansPorTipo(this.tipoSeleccionada);
  }
}
