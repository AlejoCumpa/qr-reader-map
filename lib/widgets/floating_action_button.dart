import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_map_web_reader/providers/scan_list_provider.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cacnelar', false, ScanMode.QR);
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
        if (kDebugMode) {
          print(barcodeScanRes);
        }
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
