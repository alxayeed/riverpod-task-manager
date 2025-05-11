// lib/features/task/presentation/widgets/empty_data_widget.dart
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;

  const EmptyDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
