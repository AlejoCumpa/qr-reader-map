import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';
import '../utils/utils.dart';

class ScanTile extends StatelessWidget {
  const ScanTile({super.key, required this.tipo});

  final String tipo;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              Provider.of<ScanListProvider>(context, listen: false)
                  .borrarScanPorId(scans[index].id);
            },
            child: ListTile(
              leading: Icon(tipo == 'http' ? Icons.map : Icons.web_asset,
                  color: Theme.of(context).primaryColor),
              title: Text(scans[index].valor),
              subtitle: Text(scans[index].id.toString()),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () {
                launchURL(context, scans[index]);
              },
            ),
          );
        });
  }
}
