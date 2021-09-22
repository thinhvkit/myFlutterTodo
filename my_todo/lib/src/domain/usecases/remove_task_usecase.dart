import 'package:my_todo/src/core/usecases/usecase.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/repositories/task_repository.dart';

class RemoveTaskUseCase implements UseCase<void, Task> {
  final TaskRepository _taskRepository;

  RemoveTaskUseCase(this._taskRepository);

  @override
  Future<void> call({required Task params}) {
    return _taskRepository.removeTask(params);
  }
}
