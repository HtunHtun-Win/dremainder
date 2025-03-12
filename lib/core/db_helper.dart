import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _db;

  Future<Database?> get database async {
    if (_db != null) return _db;
    _db = await init();
    return _db;
  }

  Future<Database> init() async {
    return await openDatabase(
      'my_db.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE ttask (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isDone TINYINT,
            date DATE
          )
        ''');
      },
    );
  }

  Future<void> close() async {
    final db = await database;
    db!.close();
  }
}