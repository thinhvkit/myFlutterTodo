part of 'local_task_bloc.dart';

@immutable
abstract class LocalTaskEvent extends Equatable {
  final Task task;

  const LocalTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class GetAllTasks {
  const GetAllTasks();
}

class UpdateTask extends LocalTaskEvent {
  const UpdateTask(Task task) : super(task: task);
}

class RemoveTask extends LocalTaskEvent {
  const RemoveTask(Task task) : super(task: task);
}

class SaveTask extends LocalTaskEvent {
  const SaveTask(Task task) : super(task: task);
}
