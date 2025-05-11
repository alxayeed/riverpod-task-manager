import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/update_task_usecase.dart';

final updateTaskProvider = StateNotifierProvider<UpdateTaskNotifier, AsyncValue<void>>((ref) {
  final useCase = ref.watch(updateTaskUseCaseProvider);

  return UpdateTaskNotifier(useCase);
});

class UpdateTaskNotifier extends StateNotifier<AsyncValue<void>> {
  final UpdateTaskUseCase _updateTask;

  UpdateTaskNotifier(this._updateTask) : super(const AsyncData(null));

  Future<void> update(TaskEntity task) async {
    state = const AsyncLoading();
    try {
      await _updateTask(task);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
