import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo/src/core/params/task_request.dart';
import 'package:my_todo/src/core/resources/data_state.dart';
import 'package:my_todo/src/data/models/visibility_filter.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/core/bloc/bloc_with_state.dart';
import 'package:my_todo/src/domain/usecases/get_saved_tasks_usecase.dart';
import 'package:my_todo/src/domain/usecases/get_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/remove_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/save_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/update_task_usecase.dart';

part 'local_task_event.dart';
part 'local_task_state.dart';

class LocalTaskBloc extends BlocWithState<LocalTaskEvent, LocalTaskState> {
  final GetTaskUseCase _getTaskUseCase;
  final GetSavedTaskUseCase _getSavedTaskUseCase;
  final SaveTaskUseCase _saveTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final RemoveTaskUseCase _removeTaskUseCase;

  int _page = 1;
  static const int _pageSize = 20;

  LocalTaskBloc(
      this._getTaskUseCase,
    this._getSavedTaskUseCase,
    this._saveTaskUseCase,
    this._updateTaskUseCase,
    this._removeTaskUseCase,
  ) : super(LocalTaskLoading());

  @override
  Stream<LocalTaskState> mapEventToState(
    LocalTaskEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdatedToState(event);
    } else if (event is GetAllTasks) {
      yield* _getTasks(event);
    } else if (event is UpdateTask) {
      await _updateTaskUseCase(params: event.task);
      yield* _getAllSavedTask();
    } else if (event is RemoveTask) {
      await _removeTaskUseCase(params: event.task);
      yield* _getAllSavedTask();
    } else if (event is SaveTask) {
      await _saveTaskUseCase(params: event.task);
      yield* _getAllSavedTask();
    }
  }

  Stream<LocalTaskState> _mapFilterUpdatedToState(
    FilterUpdated event,
  ) async* {
      final tasks = await _getSavedTaskUseCase();
      yield LocalTaskDone(
        _mapTodosToFilteredTodos(
          tasks,
          event.filter,
        ),
        event.filter,
      );
  }

  Stream<LocalTaskState> _getTasks(LocalTaskEvent event) async* {
    yield* runBlocProcess(() async* {
      final dataState =
      await _getTaskUseCase(params: TaskRequestParams(page: _page, pageSize: _pageSize));

      if (dataState is DataSuccess) {
        final tasks = dataState.data ?? [];
        _page++;

        final visibilityFilter = state is LocalTaskDone
            ? (state as LocalTaskDone).activeFilter
            : VisibilityFilter.all;
        yield LocalTaskDone(
            _mapTodosToFilteredTodos(
              tasks,
              visibilityFilter,
            ),
            visibilityFilter);

      }

      if (dataState is DataFailed) {
        yield LocalTaskError(dataState.error);
      }
    });
  }

  Stream<LocalTaskState> _getAllSavedTask() async* {
    final tasks = await _getSavedTaskUseCase();
    final visibilityFilter = state is LocalTaskDone
        ? (state as LocalTaskDone).activeFilter
        : VisibilityFilter.all;
    yield LocalTaskDone(
        _mapTodosToFilteredTodos(
          tasks,
          visibilityFilter,
        ),
        visibilityFilter);
  }

  List<Task> _mapTodosToFilteredTodos(
      List<Task> tasks, VisibilityFilter filter) {
    return tasks.where((task) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !task.complete;
      } else {
        return task.complete;
      }
    }).toList();
  }
}
