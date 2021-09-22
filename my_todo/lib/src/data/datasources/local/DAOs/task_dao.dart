import 'package:floor/floor.dart';

import '../../../../core/utils/constants.dart';
import '../../../../domain/entities/task.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM $kTasksTableName')
  Future<List<Task>> getAllTasks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTask(Task task);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);
}
