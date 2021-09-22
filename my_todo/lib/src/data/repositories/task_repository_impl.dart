import 'dart:io';

import 'package:dio/dio.dart';

import 'package:my_todo/src/core/params/task_request.dart';
import 'package:my_todo/src/core/resources/data_state.dart';
import 'package:my_todo/src/data/datasources/local/app_database.dart';
import 'package:my_todo/src/data/datasources/remote/task_api_service.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiService tasksApiService;
  final AppDatabase? appDatabase;
  const TaskRepositoryImpl(Object object,
      {required this.tasksApiService, this.appDatabase});

  @override
  Future<DataState<List<Task>>> getTasks(TaskRequestParams? params) async {
    try {
      final httpResponse = await tasksApiService.getTasks();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.tasks as List<Task>);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<Task>> getSavedTasks() async {
    return appDatabase!.taskDao.getAllTasks();
  }

  @override
  Future<void> removeTask(Task task) async {
    return appDatabase?.taskDao.deleteTask(task);
  }

  @override
  Future<void> saveTask(Task task) async {
    return appDatabase?.taskDao.insertTask(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    return appDatabase?.taskDao.updateTask(task);
  }
}
