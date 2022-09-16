import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_map_web_reader/models/scan_model.dart';
export 'package:qr_map_web_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'scansDB.db');
    print(path);
    return await openDatabase(path, version: 2, readOnly: false,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );      
      ''');
    }, singleInstance: true);
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO scans(id,tipo,valor)
      VALUES ($id, '$tipo', '$valor')
      ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('scans', where: 'id=?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res[0]) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM scans where tipo = '$tipo'
    ''');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(ScanModel nuevoScan) async {
    final db = await database;
    final res =
        await db.delete('scans', where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM scans
    ''');
    return res;
  }
}
