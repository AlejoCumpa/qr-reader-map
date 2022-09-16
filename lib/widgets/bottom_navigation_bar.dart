import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_map_web_reader/providers/ui_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    return BottomNavigationBar(
        onTap: (value) {
          uiProvider.selectedMenuOpt = value;
        },
        currentIndex: uiProvider.selectedMenuOpt,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.web_stories), label: 'Direcciones'),
        ]);
  }
}
