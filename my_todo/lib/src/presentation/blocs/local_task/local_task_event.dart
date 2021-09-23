part of 'local_task_bloc.dart';

@immutable
abstract class LocalTaskEvent extends Equatable {
  const LocalTaskEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends LocalTaskEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class GetAllTasks extends LocalTaskEvent {
  const GetAllTasks();

  @override
  List<Object> get props => [];
}

class UpdateTask extends LocalTaskEvent {
  final Task task;
  const UpdateTask(this.task) ;

  @override
  List<Object> get props => [task];
}

class RemoveTask extends LocalTaskEvent {
  final Task task;
  const RemoveTask(this.task);

  @override
  List<Object> get props => [task];
}

class SaveTask extends LocalTaskEvent {
  final Task task;
  const SaveTask(this.task);

  @override
  List<Object> get props => [task];
}
