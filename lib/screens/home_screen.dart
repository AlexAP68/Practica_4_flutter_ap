import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

import '../providers/ui__provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

//Pantalla principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              //esborra la base de dades
              Provider.of<ScanListProvider>(context, listen: false).esborrarTots();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListprovider = Provider.of<ScanListProvider>(context ,listen: false);
   

//segons  el resultat de uiProvider sortira el resultat de una pantalla o un altre
    switch (currentIndex) {
      case 0:
      //geo
      scanListprovider.carregarScansByTipus("geo");
        return MapasScreen();

      case 1:
      //http
      scanListprovider.carregarScansByTipus("http");
        return DireccionsScreen();

      default:
      //default geo
      scanListprovider.carregarScansByTipus("geo");
        return MapasScreen();
    }
  }
}
