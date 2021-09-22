import 'package:my_todo/src/data/models/task_model.dart';

class TaskResponseModel {
  final String status;
  final int totalResults;
  final List<TaskModel>? tasks;

  const TaskResponseModel(
      {this.status = "", this.totalResults = 0, this.tasks});

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskResponseModel(
        status: json['status'] as String,
        totalResults: json['totalResults'] as int,
        tasks: List<TaskModel>.from((json['task'] as List<dynamic>)
            .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))));
  }
}
