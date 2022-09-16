import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/scan_model.dart';

Future launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    final url = scan.valor;
    if (!await launchUrlString(url)) {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
