import 'package:task_manager/features/task/domain/entities/task_entity.dart';
import '../../domain/repository/task_repository.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<List<TaskEntity>> getTasks() async {
    final taskModels = await localDataSource.getAllTasks();
    return taskModels.map((taskModel) => taskModel.toEntity()).toList();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.insertTask(taskModel);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(int id) async {
    await localDataSource.deleteTask(id);
  }
}
