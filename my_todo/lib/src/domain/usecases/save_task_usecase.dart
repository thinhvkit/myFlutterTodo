import 'package:my_todo/src/core/usecases/usecase.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/repositories/task_repository.dart';

class SaveTaskUseCase implements UseCase<void, Task> {
  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<void> call({Task? params}) {
    if (params != null) {
      return _taskRepository.saveTask(params);
    }
    return Future.value();
  }
}
