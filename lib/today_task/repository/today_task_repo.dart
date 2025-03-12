import 'package:dremainder/core/db_helper.dart';

class TodayTaskRepo {

  DBHelper dbObj = DBHelper();

  Future<List> getAll() async {
    final database = await dbObj.database;
    return await database!.query("ttask");
  }

  Future<void> add(Map<String,dynamic> row) async {
    final database = await dbObj.database;
    await database!.insert("ttask", row);
  }

  Future<void> toggleTask(int isDone,int id) async {
    // print("toggle");
    final database = await dbObj.database;
    await database!.update("ttask", {"isDone": isDone}, where: "id = ?", whereArgs: [id]);
  }

  Future<void> remove(int id) async {
    final database = await dbObj.database;
    await database!.delete("ttask", where: "id = ?", whereArgs: [id]);
  }

  Future<void> copyTask(String date) async {
    final database = await dbObj.database;
    await database!.rawQuery(
      '''
        CREATE TABLE IF NOT EXISTS all_task (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isDone TINYINT,
            date DATE
          )
      '''
    );
    await database.rawQuery("INSERT INTO all_task(title,isDone,date) SELECT title,isDone,date FROM ttask");
    await updateDate(date);
  }

  Future<void> updateDate(String date) async {
    final database = await dbObj.database;
    await database!.rawQuery("UPDATE ttask SET date = '$date',isDone = 0");
  }
}
