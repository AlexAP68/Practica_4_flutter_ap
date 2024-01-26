import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  // si el tipus es http abre el navegador , si no lo es abre la screen de mapa
  final url = scan.valor;
  if(scan.tipus == 'http'){
       if (!await launch(url)) {
    throw Exception('Could not launch $url');
  }
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }
 
}