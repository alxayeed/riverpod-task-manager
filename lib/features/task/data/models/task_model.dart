import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';

class TaskModel extends Equatable {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  const TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['is_done'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_done': isDone ? 1 : 0,
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isDone: entity.isDone,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isDone];
}
