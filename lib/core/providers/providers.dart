// core/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/task/data/datasources/task_local_data_source.dart';
import '../../features/task/data/repository_impl/task_repository_impl.dart';
import '../../features/task/domain/repository/task_repository.dart';
import '../../features/task/domain/usecases/add_task_usecase.dart';
import '../../features/task/domain/usecases/delete_task_usecase.dart';
import '../../features/task/domain/usecases/get_tasks_usecase.dart';
import '../../features/task/domain/usecases/update_task_usecase.dart';

// Data source provider
final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  final dataSource = TaskLocalDataSource();
  dataSource.init();
  return dataSource;
});

// Repository provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataSource = ref.watch(taskLocalDataSourceProvider);
  return TaskRepositoryImpl(localDataSource: dataSource);
});

// Use case providers
final getTasksProvider = Provider<GetTasksUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetTasksUseCase(repository);
});

final addTaskProvider = Provider<AddTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return AddTaskUseCase(repository);
});

final updateTaskProvider = Provider<UpdateTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTaskUseCase(repository);
});

final deleteTaskProvider = Provider<DeleteTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeleteTaskUseCase(repository);
});
