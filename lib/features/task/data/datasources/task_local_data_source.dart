import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';

class TaskLocalDataSource {
  static final TaskLocalDataSource _instance = TaskLocalDataSource._internal();

  factory TaskLocalDataSource() => _instance;

  late Database _db;

  TaskLocalDataSource._internal();

  static Future<TaskLocalDataSource> create() async {
    final instance = _instance;
    await instance._init();
    return instance;

  }


  Future<void> _init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tasks.db');

    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        is_done INTEGER
      )
      ''');
    });
  }

  // Create task
  Future<int> insertTask(TaskModel task) async {
    return await _db.insert('tasks', task.toMap());
  }

  // Read all tasks
  Future<List<TaskModel>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await _db.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  // Update task
  Future<int> updateTask(TaskModel task) async {
    return await _db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete task
  Future<int> deleteTask(int id) async {
    return await _db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
