// features/task/presentation/providers/task_list_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/providers.dart';
import '../../domain/entities/task_entity.dart';

final taskListProvider = FutureProvider<List<TaskEntity>>((ref) async {
  final getTasksUseCase = ref.watch(getTasksUseCaseProvider);
  return getTasksUseCase();
});
