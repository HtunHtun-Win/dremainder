import 'package:dremainder/core/task_model.dart';
import 'package:dremainder/today_task/repository/today_task_repo.dart';
import 'package:flutter/material.dart';

class TodayTaskService {

  TodayTaskRepo repo = TodayTaskRepo();

  Future<List> getTodayTasks() async {
    return await repo.getAll();
  }

  Future<void> addTodayTask(TaskModel row) async {
    debugPrint(row.title);
    await repo.add(row.toMap());
  }

  Future<void> toggleTask(bool isDone,int id) async {
    await repo.toggleTask(isDone ? 1 : 0, id);
  }

  Future<void> remove(int id) async {
    await repo.remove(id);
  }

  Future<void> copyTask(String date) async {
    await repo.copyTask(date);
  }
}