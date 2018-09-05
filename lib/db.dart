import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import './models/smartCredentials.dart';

// class SmartCredentialDatabase {
//   Database _db;

//   Future create() async {
//     Directory path = await getApplicationDocumentsDirectory();
//     String dbPath = join(path.path, "database.db");

//     _db = await openDatabase(dbPath, version: 1,onCreate: this._onCreate);
//   }

//   Future<Database> initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "mainone.db");
//     var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return theDb;
//   }

//   Future  _onCreate(Database db, int version) async {
//     await db.execute("""CREATE TABLE SmartCredentials(id STRING PRIMARY KEY,
//         un TEXT, pw TEXT,bk TEXT,bi TEXT,ccn TEXT,cccvv TEXT,ccexp TEXT,ccpin TEXT,dcn TEXT,dccvv TEXT,dcexp TEXT,
//         dcpin TEXT,dcfimg TEXT,dcbimg TEXT,ccfimg TEXT,ccbimg TEXT)""");

//     print("Database was Created!");
//   }

// Future upsertSmartCredentials(SmartCredentials mycard) async {
//     var count = Sqflite.firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM SmartCredentials WHERE un = ?", [mycard.un]));
//     if (count == 0) {
//       mycard.id = await _db.insert("SmartCredentials", mycard.toMap());
//     } else {
//       await _db.update("SmartCredentials", mycard.toMap(), where: "id = ?", whereArgs: [mycard.id]);
//     }

//     return mycard;
//   }
// Future fetchSmartCredentials(String id) async {
//     List results = await _db.query("SmartCredentials", columns: SmartCredentials.columns, where: "un = ?", whereArgs: [id]);

//     SmartCredentials mycard = SmartCredentials.fromMap(results[0]);

//     return mycard;
//   }
// }

class SmartCredentialDatabase {
  static final SmartCredentialDatabase scDatabase =
      new SmartCredentialDatabase._internal();

  final String tableName = "SmartCredentials";

  Database localDatabase;

  bool init = false;

  factory SmartCredentialDatabase() {
    return scDatabase;
  }

  SmartCredentialDatabase._internal();

  Future<Database> _getDb() async {
    if (!init) await _init();
    return localDatabase;
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test123.db");
    localDatabase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          """CREATE TABLE SmartCredentials(id integer PRIMARY KEY autoincrement, 
        un TEXT, pw TEXT,bk TEXT,bi TEXT,ccn TEXT,cccvv TEXT,ccexp TEXT,ccpin TEXT,dcn TEXT,dccvv TEXT,dcexp TEXT,
        dcpin TEXT,dcfimg TEXT,dcbimg TEXT,ccfimg TEXT,ccbimg TEXT)""");
    });
    init = true;
  }

  Future insertSmartCredentials(SmartCredentials mycard) async {
    var db = await _getDb();
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM SmartCredentials WHERE id = ?", [mycard.id]));
    if (count == 0) {
      mycard.id = await db.insert("SmartCredentials", mycard.toMap());
    } else {
      await db.update("SmartCredentials", mycard.toMap(),
          where: "id = ?", whereArgs: [mycard.id]);
    }
    return mycard;
  }

  Future upsertSmartCredentials(SmartCredentials mycard) async {
    var db = await _getDb();
    if (mycard.id == null) {
      mycard.id = await db.insert("SmartCredentials", mycard.toMap());
    } else {
      var count = Sqflite.firstIntValue(await db.rawQuery(
          "SELECT COUNT(*) FROM SmartCredentials WHERE id = ?", [mycard.id]));
      if (count != 0) {
        await db.update("SmartCredentials", mycard.toMap(),
            where: "id = ?", whereArgs: [mycard.id]);
      } else {
        mycard.id = await db.insert("SmartCredentials", mycard.toMap());
      }
    }
    return mycard;
  }

  Future fetchSmartCredentials(int id) async {
    var db = await _getDb();
    List results; //= await db.query("SmartCredentials",
        //columns: SmartCredentials.columns, where: "id = ?", whereArgs: [id]);

    SmartCredentials oSC = SmartCredentials.fromMap(results[0]);

    return oSC;
  }

  Future<List> fetchAllData() async {
    var db = await _getDb();
    List results = await db.query("SmartCredentials");

    List sc = new List();
    results.forEach((f) {
      SmartCredentials oSC = SmartCredentials.fromMap(f);
      sc.add(oSC);
    });
    return sc;
  }
}




