import 'package:my_todo/src/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({id, name, complete})
      : super(id: id, name: name, complete: complete);

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'] as String,
        name: map['name'] as String,
        complete: map['complete'] as bool);
  }
}
