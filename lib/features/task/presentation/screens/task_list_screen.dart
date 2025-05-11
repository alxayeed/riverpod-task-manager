// lib/features/task/presentation/screens/task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/task_list_provider.dart';
import '../widgets/empty_data_widget.dart';
import '../widgets/task_item_widget.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsyncValue = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: taskListAsyncValue.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const EmptyDataWidget(message: 'No tasks available');
          }
          return RefreshIndicator(
            onRefresh: () async {
              final _ = await ref.refresh(taskListProvider.future);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItemWidget(task: task);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
