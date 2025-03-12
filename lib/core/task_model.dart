class TaskModel {
  int? id;
  String title;
  bool isDone;
  String date;

  TaskModel({this.id, required this.title, this.isDone = false , required this.date});

  factory TaskModel.fromMap(Map<String, dynamic> map)=>TaskModel(
    id : map['id'],
    title : map['title'],
    isDone : map['isDone'] == 1,
    date : map['date']
  );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['title'] = title;
    map['isDone'] = isDone ? 1 : 0;
    map['date'] = date;
    return map;
  }

  void toggleDone() {
    isDone = !isDone;
  }
  
}