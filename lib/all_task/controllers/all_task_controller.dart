import 'package:dremainder/all_task/services/all_task_service.dart';
import 'package:dremainder/core/task_model.dart';
import 'package:get/get.dart';

class AllTaskController extends GetxController{
  var dates = [].obs;
  var tasks = [].obs;

  @override
  void onInit(){
    super.onInit();
    getDate();
  }

  AllTaskService service = AllTaskService();

  void getDate() async {
    var datas = await service.getDate();
    dates.clear();
    for (var data in datas) {
      dates.add(data);
    }
  }

  void getByDate(String date) async {
    var datas = await service.getByDate(date);
    tasks.clear();
    for (var data in datas) {
      tasks.add(TaskModel.fromMap(data));
    }
  }

  void toggleTask(bool isDone,int id) async{
    service.toggleTask(isDone, id);
    getDate();
  }
  
  Future<void> remove(TaskModel task) async {
    service.remove(task.id!);
    tasks.remove(task);
  }
}