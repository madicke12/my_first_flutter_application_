import 'package:flutter/material.dart';
import 'package:my_first_flutter_application_/screens/task_list_screen.dart';
import 'package:my_first_flutter_application_/screens/add_task_screen.dart';
import 'package:my_first_flutter_application_/screens/edit_task_screen.dart';
import 'package:my_first_flutter_application_/model/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebaseconfig.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      home: const TaskListScreen(),
      routes: {
        '/add-task': (context) => const AddTaskScreen(),
        '/edit-task': (context) => EditTaskScreen(task: ModalRoute.of(context)!.settings.arguments as Task),
      },
    );
  }
}