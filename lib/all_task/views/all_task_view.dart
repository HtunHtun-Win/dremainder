import 'package:dremainder/all_task/controllers/all_task_controller.dart';
import 'package:dremainder/all_task/views/today_by_date_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTaskView extends StatefulWidget {
  const AllTaskView({super.key});

  @override
  State<AllTaskView> createState() => _AllTaskViewState();
}

class _AllTaskViewState extends State<AllTaskView> {
  AllTaskController allController = Get.put(AllTaskController());

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
          "All Tasks",
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
                itemCount: allController.dates.length,
                itemBuilder: (context, index) {
                  var date = allController.dates[index];
                  return ListTile(
                    title: Text(date['date']),
                    onTap: (){
                      allController.getByDate(date['date']);
                      Get.to(()=>TodayByDateView());
                    },
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
