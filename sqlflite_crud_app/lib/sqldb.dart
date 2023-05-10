import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqldb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialisation();
      return _db;
    } else {
      return _db;
    }
  }

  initialisation() async {
    String db_path = await getDatabasesPath();
    String path = join(db_path, "biblio");
    Database mydb = await openDatabase(path, onCreate: _createDB, version: 1);
    return mydb;
  }

  _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Books (id INTEGER PRIMARY KEY AUTOINCREMENT, titre TEXT, auteur TEXT, annee INTEGER, description TEXT)");
    print("table created");
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawInsert(sql);
    return rep;
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> rep = await mydb!.rawQuery(sql);
    return rep;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawDelete(sql);
    return rep;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawUpdate(sql);
    return rep;
  }
}
