part of 'remote_task_bloc.dart';

@immutable
abstract class RemoteTaskState extends Equatable {
  const RemoteTaskState();

  @override
  List<Object> get props => [];
}

class RemoteTaskLoading extends RemoteTaskState {}

class RemoteTaskDone extends RemoteTaskState {
  final List<Task> tasks;
  final bool noMoreData;

  const RemoteTaskDone([this.tasks = const[], this.noMoreData = false]);

  @override
  List<Object> get props => [tasks, noMoreData];
}

class RemoteTaskError extends RemoteTaskState {
  final DioError? dioError;
  const RemoteTaskError(this.dioError);

  @override
  List<Object> get props => [dioError ?? ''];
}
