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
  final VisibilityFilter activeFilter;
  const LocalTaskDone(this.tasks, this.activeFilter);

  @override
  List<Object> get props => [tasks, activeFilter];
}

class LocalTaskError extends LocalTaskState {
  final DioError? dioError;
  const LocalTaskError(this.dioError);

  @override
  List<Object> get props => [dioError ?? ''];
}
