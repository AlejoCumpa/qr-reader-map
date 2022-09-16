import 'package:flutter/material.dart';
import '../widgets/scan_tile.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTile(tipo: 'http');
  }
}
