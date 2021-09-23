import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo/src/core/bloc/bloc_with_state.dart';
import 'package:my_todo/src/core/params/task_request.dart';
import 'package:my_todo/src/core/resources/data_state.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/usecases/get_task_usecase.dart';

part 'remote_task_event.dart';
part 'remote_task_state.dart';

class RemoteTaskBloc extends BlocWithState<RemoteTaskEvent, RemoteTaskState> {
  final GetTaskUseCase getTaskUseCase;
  RemoteTaskBloc(this.getTaskUseCase) : super(RemoteTaskLoading());

  final List<Task> _tasks = [];
  int _page = 1;
  static const int _pageSize = 20;

  @override
  Stream<RemoteTaskState> mapEventToState(
    RemoteTaskEvent event,
  ) async* {
    if (event is GetTasks) yield* getTasks(event);
  }

  Stream<RemoteTaskState> getTasks(RemoteTaskEvent event) async* {
    yield* runBlocProcess(() async* {
      final dataState =
          await getTaskUseCase(params: TaskRequestParams(page: _page));

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        final tasks = dataState.data;
        final noMoreData = tasks!.length < _pageSize;
        _tasks.addAll(tasks);
        _page++;

        yield RemoteTaskDone(tasks, noMoreData);
      }

      if (dataState is DataFailed) {
        yield RemoteTaskError(dataState.error);
      }
    });
  }
}
