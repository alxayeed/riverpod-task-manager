import 'package:flutter/material.dart';
import '../../domain/entities/task_entity.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskEntity task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(task.description),
        trailing: Icon(
          task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: task.isDone ? Colors.green : Colors.grey,
        ),
        onTap: () {
          // Navigate to task detail screen (if implemented)
        },
      ),
    );
  }
}
