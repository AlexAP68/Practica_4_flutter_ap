import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {

static Database? _database;
static final DBProvider db = DBProvider._();

DBProvider._();

//creamos la base de datos
Future<Database> get database async {
  if (_database == null) _database = await initDB();;
    
    return _database!;
  
}

//Hacemos diferentes consultas a la base de datos 


//creamos tabla scaner
Future<Database> initDB() async{
   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final path = join(documentsDirectory.path,'Scans.db');
  print(path);

  return await openDatabase(
    path,
    version: 1,
    onOpen: (db){},
    onCreate: (Database db, int version) async{
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipus TEXT,
          valor Text
        )
      ''');
    }
    );
 
}

//Insert
 Future<int> insertRawScan(ScanModel nouScan) async {
      final id = nouScan.id;
      final tipus = nouScan.tipus;
      final valor = nouScan.valor;

      final db = await database;

      final res = await db.rawInsert('''

      INSERT INTO Scans(id,tipus,valor)
      Values ($id, $tipus, $valor)
      ''');

      return res;
 }

 Future<int> insertScan(ScanModel nouScan) async {
 
      final db = await database;

      final res = await db.insert('Scans', nouScan.toMap());
      print(res);

      return res;
 }


//select
Future<List<ScanModel>> getAllScans() async{
    final db = await database;

      final res = await db.query('Scans');
      print(res);

      return res.isNotEmpty ?  res.map((e) => ScanModel.fromMap(e)).toList() : [];
}


//select mediante ID
Future<ScanModel?> getScanByID(int id) async{
    final db = await database;

      final res = await db.query('Scans',where: 'id = ?',whereArgs: [id]);

      if (res.isNotEmpty) {
        return ScanModel.fromMap(res.first);
        
      }
      return  null;
  }

//select mediante tipus
Future<List<ScanModel>> getAllScansbytipus( String tipus) async{
    final db = await database;

      final res = await db.query('Scans',where: 'tipus = ?',whereArgs: [tipus]);

      return res.isNotEmpty ?  res.map((e) => ScanModel.fromMap(e)).toList() : [];
}


//update
Future<int> updateScan(ScanModel nouScan) async{
    final db = await database;

      final res = await db.update('Scans',nouScan.toMap(), where: 'id = ?', whereArgs: [nouScan.id]);

      return res;
}


//delete por id
Future<int> deleteScanByID(int id) async{
    final db = await database;

      final res = await db.rawDelete(''' DELETE  FROM Scans Where id = $id ''');

      return res;
}

//delete
Future<int> deleteAll() async{
    final db = await database;

      final res = await db.rawDelete(''' DELETE  FROM Scans''');

      return res;
}


}
  
