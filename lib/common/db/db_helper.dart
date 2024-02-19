import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const _dbPath = "images_db.db";
  static late String _dir;
  static Database? _db;

  static Future<void> initDb() async {
    _dir = await getDatabasesPath();
    _db = await openDatabase(
      "$_dir/$_dbPath",
      onCreate: (Database db, int version) async {
        await db.execute("""
          CREATE TABLE images (
            id INTEGER PRIMARY KEY,
            path TEXT
          );
        """);
      },
      version: 1
    );
  }

  static Database getDb() {
    if(_db != null) return _db!;
    throw Error();
  }
}