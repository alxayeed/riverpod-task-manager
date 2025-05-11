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
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: titleController,
            decoration: inputDecoration.copyWith(labelText: 'Title'),
            validator: (value) =>
            value == null || value.isEmpty ? 'Enter title' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: inputDecoration.copyWith(labelText: 'Description'),
            validator: (value) =>
            value == null || value.isEmpty ? 'Enter description' : null,
            maxLines: 3,
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: isSubmitting ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text(
                'Submit',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
