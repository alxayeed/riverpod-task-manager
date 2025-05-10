import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  const TaskEntity({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  TaskEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isDone];
}
