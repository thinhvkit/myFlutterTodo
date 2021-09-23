import 'package:json_annotation/json_annotation.dart';
import 'package:my_todo/src/domain/entities/task.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Task {
  const TaskModel({id, name, complete = false})
      : super(id: id, name: name, complete: complete);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
