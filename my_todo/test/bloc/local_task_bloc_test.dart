import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_todo/src/data/models/visibility_filter.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/usecases/get_saved_tasks_usecase.dart';
import 'package:my_todo/src/domain/usecases/get_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/remove_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/save_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/update_task_usecase.dart';
import 'package:my_todo/src/presentation/blocs/local_task/local_task_bloc.dart';

import 'local_task_bloc_test.mocks.dart';

@GenerateMocks([
  GetTaskUseCase,
  GetSavedTaskUseCase,
  SaveTaskUseCase,
  UpdateTaskUseCase,
  RemoveTaskUseCase
])
void main() {
  final tasks = [const Task(id: "0", complete: false), const Task(id: "1", complete: true)];

  group("LocalTaskBloc", () {
    var _getTaskUseCase = MockGetTaskUseCase();
    var _getSavedTaskUseCase = MockGetSavedTaskUseCase();
    var _saveTaskUseCase = MockSaveTaskUseCase();
    var _updateTaskUseCase = MockUpdateTaskUseCase();
    var _removeTaskUseCase = MockRemoveTaskUseCase();

    blocTest("should update the VisibilityFilter when filter is active",
        build: () {
          LocalTaskBloc localTaskBloc = LocalTaskBloc(_getTaskUseCase,_getSavedTaskUseCase,
              _saveTaskUseCase, _updateTaskUseCase, _removeTaskUseCase);
          when(_getSavedTaskUseCase())
              .thenAnswer((_) async => Future.value(tasks));
          return localTaskBloc;
        },
        act: (LocalTaskBloc bloc) async =>
            {bloc.add(const FilterUpdated(VisibilityFilter.active))},
        expect: () => <LocalTaskState>[
              const LocalTaskDone([Task(id: "0", complete: false)], VisibilityFilter.active),
            ]);

    blocTest("should update the VisibilityFilter when filter is complete",
        build: () {
          LocalTaskBloc localTaskBloc = LocalTaskBloc(_getTaskUseCase, _getSavedTaskUseCase,
              _saveTaskUseCase, _updateTaskUseCase, _removeTaskUseCase);
          when(_getSavedTaskUseCase())
              .thenAnswer((_) async => Future.value(tasks));
          return localTaskBloc;
        },
        act: (LocalTaskBloc bloc) async =>
            {bloc.add(const FilterUpdated(VisibilityFilter.completed))},
        expect: () => <LocalTaskState>[
              const LocalTaskDone(
                  [Task(id: "1", complete: true)], VisibilityFilter.completed),
            ]);
  });
}
