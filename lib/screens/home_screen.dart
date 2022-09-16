import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_map_web_reader/providers/scan_list_provider.dart';
import 'package:qr_map_web_reader/providers/ui_provider.dart';
import 'package:qr_map_web_reader/screens/direccione_screen.dart';
import 'package:qr_map_web_reader/screens/mapas_screen.dart';
import 'package:qr_map_web_reader/widgets/floating_action_button.dart';
import 'package:qr_map_web_reader/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .borrarTodos();
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const Center(
        child: _HomePageBody(),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//iOS
// AIzaSyCmDarCUazTSyo-hY2LHiKqsvkmarzm2BE

//Android
//AIzaSyCOX_bcZJdR2uHak6172OHD3RDntHWHBA4

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasScreen();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesScreen();
      default:
        return const MapasScreen();
    }
  }
}
