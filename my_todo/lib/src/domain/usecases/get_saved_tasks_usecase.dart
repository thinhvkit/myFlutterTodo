import 'package:my_todo/src/core/usecases/usecase.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/repositories/task_repository.dart';

class GetSavedTaskUseCase implements UseCase<List<Task>, Future<void>> {
  final TaskRepository _taskRepository;

  GetSavedTaskUseCase(this._taskRepository);

  @override
  Future<List<Task>> call({Future<void>? params}) {
    return _taskRepository.getSavedTasks();
  }
}
