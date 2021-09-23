import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_todo/src/data/datasources/remote/task_api_service.dart';
import 'package:my_todo/src/data/repositories/task_repository_impl.dart';
import 'package:my_todo/src/domain/repositories/task_repository.dart';
import 'package:my_todo/src/domain/usecases/get_saved_tasks_usecase.dart';
import 'package:my_todo/src/domain/usecases/get_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/remove_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/save_task_usecase.dart';
import 'package:my_todo/src/domain/usecases/update_task_usecase.dart';
import 'package:my_todo/src/presentation/blocs/local_task/local_task_bloc.dart';
import 'package:my_todo/src/presentation/blocs/remote_task/remote_task_bloc.dart';

import 'core/utils/constants.dart';
import 'data/datasources/local/app_database.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // *
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  injector.registerSingleton<AppDatabase>(database);

  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<TaskApiService>(TaskApiService(injector()));

  // *
  injector.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(injector(), injector()),
  );

  // UseCases
  injector.registerSingleton<GetTaskUseCase>(GetTaskUseCase(injector()));

  // *
  injector
      .registerSingleton<GetSavedTaskUseCase>(GetSavedTaskUseCase(injector()));
  injector.registerSingleton<SaveTaskUseCase>(SaveTaskUseCase(injector()));
  injector.registerSingleton<RemoveTaskUseCase>(RemoveTaskUseCase(injector()));
  injector.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase(injector()));

  // Blocs
  injector.registerFactory<RemoteTaskBloc>(
    () => RemoteTaskBloc(injector()),
  );

  // *
  injector.registerFactory<LocalTaskBloc>(
    () => LocalTaskBloc(injector(), injector(), injector(), injector()),
  );
}
