import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/home_screen.dart';
import 'package:qr_scan/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// Widget que representa un boton flotante para  escanear codigos QR
class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');
        
        //String barcodeScanRes = 'https://paucasesnovescifp.cat/';
        //String barcodeScanRes = 'geo: 39.706556, 3.068144';
        
        // Utilitza el FlutterBarcodeScanner para escanear un codi QR
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ec5353', 'cancel·lar', false, ScanMode.QR);

        if (barcodeScanRes != '-1') {//-1 perque quan es cancel·la retorna un -1
          // Solo realiza las operaciones si elusuario no cancela
          final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
          ScanModel nouScan = ScanModel(valor: barcodeScanRes);  
          scanListProvider.nouScan(barcodeScanRes);
          launchURL(context, nouScan);
        } else {
          // Fuerza a volver a la pagina Home si el usuario cancela
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
    );
  }
}