import '../entities/task_entity.dart';
import '../repository/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(TaskEntity task) {
    return repository.updateTask(task);
  }
}
