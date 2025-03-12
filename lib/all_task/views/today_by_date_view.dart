import 'package:dremainder/all_task/controllers/all_task_controller.dart';
import 'package:dremainder/core/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayByDateView extends StatefulWidget {
  const TodayByDateView({super.key});

  @override
  State<TodayByDateView> createState() => _TodayByDateViewState();
}

class _TodayByDateViewState extends State<TodayByDateView> {
  AllTaskController allController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.now();
    // String todayDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Tasks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: allController.tasks.length,
                itemBuilder: (context, index) {
                  TaskModel task = allController.tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (value) {
                        task.isDone = value!;
                        allController.toggleTask(task.isDone, task.id!);
                        setState(() {});
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        allController.remove(task);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
