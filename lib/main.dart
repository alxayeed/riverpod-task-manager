import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/providers.dart';
import 'features/task/data/datasources/task_local_data_source.dart';
import 'features/task/presentation/screens/add_task_screen.dart';
import 'features/task/presentation/screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localDataSource = await TaskLocalDataSource.create();

  runApp(
    ProviderScope(
      overrides: [
        taskLocalDataSourceProvider.overrideWithValue(localDataSource),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define routes for navigation
      routes: {
        '/': (context) => const TaskListScreen(),
        '/add-task': (context) => const AddTaskScreen(),
      },
    );
  }
}
