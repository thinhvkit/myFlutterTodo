import '../../core/params/task_request.dart';
import '../../core/resources/data_state.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<DataState<List<Task>>> getTasks(TaskRequestParams? params);

  Future<List<Task>> getSavedTasks();

  Future<void> saveTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> removeTask(Task task);
}
