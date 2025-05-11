import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task_entity.dart';
import '../providers/delete_task_provider.dart';
import '../providers/task_list_provider.dart';
import '../providers/update_task_provider.dart';

class TaskItemWidget extends ConsumerWidget {
  final TaskEntity task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(task.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final shouldDelete = await _showDeleteConfirmation(context);
        if (shouldDelete) {
          await ref.read(deleteTaskProvider(task.id!).future);
          ref.invalidate(taskListProvider);
          return true;
        } else {
          return false;
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                  color: task.isDone ? Colors.green : Colors.grey,
                ),
                onPressed: () async {
                  final updatedTask = task.copyWith(isDone: !task.isDone);
                  final notifier = ref.read(updateTaskProvider.notifier);
                  await notifier.update(updatedTask);
                  ref.invalidate(taskListProvider);
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                        color: task.isDone ? Colors.grey : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: task.isDone ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
