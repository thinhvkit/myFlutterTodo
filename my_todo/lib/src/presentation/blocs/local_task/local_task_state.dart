part of 'local_task_bloc.dart';

@immutable
abstract class LocalTaskState extends Equatable {
  const LocalTaskState();

  @override
  List<Object> get props => [];
}

class LocalTaskLoading extends LocalTaskState {}

class LocalTaskDone extends LocalTaskState {
  final List<Task> tasks;
  const LocalTaskDone([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];
}

class LocalTaskError extends LocalTaskState {}
