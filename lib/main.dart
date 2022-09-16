import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_map_web_reader/providers/scan_list_provider.dart';
import 'package:qr_map_web_reader/providers/ui_provider.dart';
import 'package:qr_map_web_reader/screens/home_screen.dart';
import 'package:qr_map_web_reader/screens/map_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
          title: 'QR Reader',
          initialRoute: 'home',
          theme: ThemeData(
              primaryColor: Colors.deepPurple,
              appBarTheme:
                  const AppBarTheme(backgroundColor: Colors.deepPurple),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  selectedIconTheme: IconThemeData(color: Colors.deepPurple),
                  selectedLabelStyle: TextStyle(color: Colors.deepPurple)),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.indigo)),
          debugShowCheckedModeBanner: false,
          routes: {
            'home': (_) => const HomeScreen(),
            'mapa': (_) => MapaScreen(),
          }),
    );
  }
}
