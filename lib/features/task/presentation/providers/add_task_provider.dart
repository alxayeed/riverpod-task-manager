// features/task/presentation/providers/add_task_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../domain/entities/task_entity.dart';


final addTaskProvider = FutureProvider.family<void, TaskEntity>((ref, task) async {
  final addTaskUseCase = ref.watch(addTaskUseCaseProvider);
  return addTaskUseCase(task);
});
