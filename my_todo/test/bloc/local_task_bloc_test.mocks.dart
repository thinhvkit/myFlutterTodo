// Mocks generated by Mockito 5.0.16 from annotations
// in my_todo/test/bloc/local_task_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:my_todo/src/core/params/task_request.dart' as _i7;
import 'package:my_todo/src/core/resources/data_state.dart' as _i3;
import 'package:my_todo/src/domain/entities/task.dart' as _i6;
import 'package:my_todo/src/domain/repositories/task_repository.dart' as _i2;
import 'package:my_todo/src/domain/usecases/get_saved_tasks_usecase.dart'
    as _i8;
import 'package:my_todo/src/domain/usecases/get_task_usecase.dart' as _i4;
import 'package:my_todo/src/domain/usecases/remove_task_usecase.dart' as _i11;
import 'package:my_todo/src/domain/usecases/save_task_usecase.dart' as _i9;
import 'package:my_todo/src/domain/usecases/update_task_usecase.dart' as _i10;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTaskRepository_0 extends _i1.Fake implements _i2.TaskRepository {}

class _FakeDataState_1<T> extends _i1.Fake implements _i3.DataState<T> {}

/// A class which mocks [GetTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTaskUseCase extends _i1.Mock implements _i4.GetTaskUseCase {
  MockGetTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TaskRepository get taskRepository =>
      (super.noSuchMethod(Invocation.getter(#taskRepository),
          returnValue: _FakeTaskRepository_0()) as _i2.TaskRepository);
  @override
  _i5.Future<_i3.DataState<List<_i6.Task>>> call(
          {_i7.TaskRequestParams? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
              returnValue: Future<_i3.DataState<List<_i6.Task>>>.value(
                  _FakeDataState_1<List<_i6.Task>>()))
          as _i5.Future<_i3.DataState<List<_i6.Task>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetSavedTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSavedTaskUseCase extends _i1.Mock
    implements _i8.GetSavedTaskUseCase {
  MockGetSavedTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i6.Task>> call({_i5.Future<void>? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
              returnValue: Future<List<_i6.Task>>.value(<_i6.Task>[]))
          as _i5.Future<List<_i6.Task>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTaskUseCase extends _i1.Mock implements _i9.SaveTaskUseCase {
  MockSaveTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> call({_i6.Task? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [UpdateTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateTaskUseCase extends _i1.Mock implements _i10.UpdateTaskUseCase {
  MockUpdateTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> call({_i6.Task? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTaskUseCase extends _i1.Mock implements _i11.RemoveTaskUseCase {
  MockRemoveTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> call({_i6.Task? params}) =>
      (super.noSuchMethod(Invocation.method(#call, [], {#params: params}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}
