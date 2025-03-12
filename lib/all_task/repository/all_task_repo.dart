import 'package:dremainder/core/db_helper.dart';

class AllTaskRepo {

  DBHelper dbObj = DBHelper();

  Future<List> getDate() async {
    final database = await dbObj.database;
    return await database!.query("all_task",columns: ["date"],groupBy: "date",orderBy: "date desc");
  }

  Future<List> getByDate(String date) async {
    final database = await dbObj.database;
    return await database!.query("all_task",where: "date=?",whereArgs: [date]);
  }

  Future<void> toggleTask(int isDone,int id) async {
    final database = await dbObj.database;
    await database!.update("all_task", {"isDone": isDone}, where: "id = ?", whereArgs: [id]);
  }

  Future<void> remove(int id) async {
    final database = await dbObj.database;
    await database!.delete("all_task", where: "id = ?", whereArgs: [id]);
  }
}