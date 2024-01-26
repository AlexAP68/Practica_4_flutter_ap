import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  
  List<ScanModel> scans = [];
  String tipusSelecionat = 'http';


//Funciones para llamar a las consultas 

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id =  await  DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSelecionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }

    return nouScan;
  }

  carregarScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  carregarScansByTipus(String tipus) async{
    final scans = await DBProvider.db.getAllScansbytipus(tipus);
    this.scans = [...scans];
    notifyListeners();
  }

  esborrarTots() async {
    await DBProvider.db.deleteAll();
    this.scans = [];
    notifyListeners();
  }

  esborraPerTipus(int id) async {
    await DBProvider.db.deleteScanByID(id);
    this.scans.removeWhere((scan) => scan.id == id);
    notifyListeners();
  }

}