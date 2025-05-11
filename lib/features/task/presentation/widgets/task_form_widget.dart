// lib/features/task/presentation/widgets/task_form_widget.dart
import 'package:flutter/material.dart';

class TaskFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const TaskFormWidget({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) =>
            value == null || value.isEmpty ? 'Enter title' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) =>
            value == null || value.isEmpty ? 'Enter description' : null,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: isSubmitting ? null : onSubmit,
            child: isSubmitting
                ? const CircularProgressIndicator()
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
