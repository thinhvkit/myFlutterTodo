part of 'remote_task_bloc.dart';

@immutable
abstract class RemoteTaskEvent extends Equatable {
  const RemoteTaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends RemoteTaskEvent {
  const GetTasks();
}
