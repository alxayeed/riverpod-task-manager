import 'package:flutter/material.dart';

import '../../domain/entities/task_entity.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskEntity task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the task details screen
        // Navigator.push(
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TaskDetailsScreen(task: task),
        //   ),
        // );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: GridTile(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the task details screen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TaskDetailsScreen(task: task),
                  //   ),
                  // );
                },
                child: const Text('Details'),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                const SizedBox(height: 8.0),
                Icon(
                  task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                  color: task.isDone ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
