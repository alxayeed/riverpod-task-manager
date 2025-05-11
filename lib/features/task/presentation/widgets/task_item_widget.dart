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
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          title: Text(
            task.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(task.description),
          trailing: IconButton(
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
        ),
      ),
    );
  }

  // Show a confirmation dialog for deletion
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
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }
}
