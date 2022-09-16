import 'package:flutter/material.dart';
import 'package:qr_map_web_reader/widgets/scan_tile.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTile(tipo: 'geo');
  }
}
