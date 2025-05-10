import '../entities/task_entity.dart';
import '../repository/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(TaskEntity task) {
    return repository.addTask(task);
  }
}
