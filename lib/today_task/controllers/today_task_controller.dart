import 'dart:io';

import 'package:dremainder/core/task_model.dart';
import 'package:dremainder/today_task/services/today_task_service.dart';
import 'package:get/get.dart';

class TodayTaskController extends GetxController{
  var tasks = [].obs;

  @override
  void onInit(){
    super.onInit();
    getAll();
  }

  TodayTaskService service = TodayTaskService();

  void getAll() async {
    var datas = await service.getTodayTasks();
    tasks.clear();
    for (var data in datas) {
      tasks.add(TaskModel.fromMap(data));
    }
    //
    DateTime dateTime = DateTime.now();
    String todayDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    if(tasks.isNotEmpty && tasks[0].date != todayDate){
      copyTask(todayDate);
    }
  }

  void refreshTest() async{
    sleep(Duration(seconds: 1));
    var datas = await service.getTodayTasks();
    tasks.clear();
    for (var data in datas) {
      tasks.add(TaskModel.fromMap(data));
    }
  }

  void addTask(TaskModel row) async{
    service.addTodayTask(row);
    getAll();
  }

  void toggleTask(bool isDone,int id) async{
    service.toggleTask(isDone, id);
    getAll();
  }
  Future<void> remove(TaskModel task) async {
    service.remove(task.id!);
    tasks.remove(task);
  }

  void copyTask(String date) async{
    service.copyTask(date);
  }
}