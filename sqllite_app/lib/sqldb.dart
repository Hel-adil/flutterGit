import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqldb{

  static Database? _db;
  Future<Database?> get db async {
    if(_db==null){
      _db=await initialisation();
      return _db;
    }
    else{
      return _db;
    }
    
  }


  initialisation()async {
    String db_path = await getDatabasesPath();
    String path = join(db_path, "biblio" );
    Database mydb=await openDatabase(path, onCreate: _createDB, version: 1);
    return mydb;
  }
  _createDB(Database db , int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS livres (id INTEGER PRIMARY KEY AUTO_INCREMENT, titre TEXT, auteur TEXT, annee INTEGER, image TEXT, description TEXT)");
    print("table created");
  }


  insertData(String sql) async{
    Database? mydb = await db;
    int rep = await mydb!.rawInsert(sql);
    return rep;

  }

  readData (String sql) async{
    Database? mydb = await db;
    List<Map<String, dynamic>> rep = await mydb!.rawQuery(sql);
    return rep;
  }






}