import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/task_entity.dart';
import '../providers/add_task_provider.dart';
import '../widgets/task_form_widget.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      final task = TaskEntity(
        title: _titleController.text,
        description: _descriptionController.text,
      );

      await ref.read(addTaskProvider(task).future);

      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
      });

      Navigator.pop(context); // Navigate back to task list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskFormWidget(
          formKey: _formKey,
          titleController: _titleController,
          descriptionController: _descriptionController,
          isSubmitting: _isSubmitting,
          onSubmit: _submit,
        ),
      ),
    );
  }
}
