import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/usecases/get_saved_tasks_usecase.dart';
import 'package:my_todo/src/domain/usecases/remove_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/save_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/update_task_usecase.dart';

part 'local_task_event.dart';
part 'local_task_state.dart';

class LocalTaskBloc extends Bloc<LocalTaskEvent, LocalTaskState> {
  final GetSavedTaskUseCase _getSavedTaskUseCase;
  final SaveTaskUseCase _saveTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final RemoveTaskUseCase _removeTaskUseCase;

  LocalTaskBloc(
    this._getSavedTaskUseCase,
    this._saveTaskUseCase,
    this._updateTaskUseCase,
    this._removeTaskUseCase,
  ) : super(LocalTaskLoading());

  @override
  Stream<LocalTaskState> mapEventToState(
    LocalTaskEvent event,
  ) async* {
    if (event is GetAllTasks) {
      yield* _getAllSavedTask();
    }
    else if (event is UpdateTask){
      await _updateTaskUseCase(params: event.task);
      yield* _getAllSavedTask();
    }
    else if (event is RemoveTask) {
      await _removeTaskUseCase(params: event.task);
      yield* _getAllSavedTask();
    }
    else if (event is SaveTask) {
      await _saveTaskUseCase(params: event.task);
      yield* _getAllSavedTask();
    }
  }

  Stream<LocalTaskState> _getAllSavedTask() async* {
    final task = await _getSavedTaskUseCase();
    yield LocalTaskDone(task);
  }
}
