import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/providers.dart';


final deleteTaskProvider = FutureProvider.family<void, int>((ref, taskId) async {
  final deleteTaskUseCase = ref.watch(deleteTaskUseCaseProvider);
  return deleteTaskUseCase(taskId);
});
