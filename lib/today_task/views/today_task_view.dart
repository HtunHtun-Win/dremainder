import 'package:dremainder/all_task/views/all_task_view.dart';
import 'package:dremainder/core/task_model.dart';
import 'package:dremainder/today_task/controllers/today_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayTaskView extends StatefulWidget {
  const TodayTaskView({super.key});

  @override
  State<TodayTaskView> createState() => _TodayTaskViewState();
}

class _TodayTaskViewState extends State<TodayTaskView> {
  TodayTaskController controller = Get.put(TodayTaskController());
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // controller.getAll();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String todayDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Today Task ($todayDate)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: () {
          controller.refreshTest();
          }, icon: Icon(Icons.refresh)),
          IconButton(onPressed: () {
          Get.to(() => AllTaskView());
          }, icon: Icon(Icons.menu)),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter task title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      Get.snackbar(
                        "Empty Title ",
                        "Title cannot be empty",
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        colorText: Colors.white,
                      );
                    } else {
                      controller.addTask(
                        TaskModel(
                          title: titleController.text.trim(),
                          isDone: false,
                          date: todayDate,
                        ),
                      );
                      titleController.clear();
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.tasks.length,
                itemBuilder: (context, index) {
                  TaskModel task = controller.tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (value) {
                        task.isDone = value!;
                        controller.toggleTask(task.isDone, task.id!);
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
                        controller.remove(task);
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
