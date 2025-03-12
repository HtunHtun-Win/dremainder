import 'package:dremainder/all_task/repository/all_task_repo.dart';

class AllTaskService {

  AllTaskRepo repo = AllTaskRepo();

Future<List> getDate() async {
    return await repo.getDate();
  }

  Future<List> getByDate(String date) async {
    return await repo.getByDate(date);
  }

  Future<void> toggleTask(bool isDone,int id) async {
    await repo.toggleTask(isDone ? 1 : 0, id);
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
  }
}