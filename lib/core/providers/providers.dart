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
  return dataSource;
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataSource = ref.watch(taskLocalDataSourceProvider);
  return TaskRepositoryImpl(localDataSource: dataSource);
});

// Use case providers
final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  return GetTasksUseCase(taskRepository);
});

final addTaskUseCaseProvider = Provider<AddTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return AddTaskUseCase(repository);
});

final updateTaskUseCaseProvider = Provider<UpdateTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTaskUseCase(repository);
});

final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeleteTaskUseCase(repository);
});
