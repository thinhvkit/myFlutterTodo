import 'package:my_todo/src/core/params/task_request.dart';
import 'package:my_todo/src/core/resources/data_state.dart';
import 'package:my_todo/src/core/usecases/usecase.dart';
import 'package:my_todo/src/domain/entities/task.dart';
import 'package:my_todo/src/domain/repositories/task_repository.dart';

class GetTaskUseCase
    implements UseCase<DataState<List<Task>>, TaskRequestParams> {
  final TaskRepository taskRepository;
  GetTaskUseCase(this.taskRepository);

  @override
  Future<DataState<List<Task>>> call({TaskRequestParams? params}) {
    return taskRepository.getTasks(params);
  }
}
