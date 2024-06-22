import 'package:flutter/material.dart';
import 'package:my_first_flutter_application_/model/task.dart';
import 'package:my_first_flutter_application_/widgets/task_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _selectedStatus = 'All'; // Default filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste de tache',
          style:  TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      actions: [
  PopupMenuButton<String>(
    onSelected: (String value) {
      setState(() {
        _selectedStatus = value;
      });
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'All',
        child: Text(
          'All',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
      const PopupMenuItem<String>(
        value: 'To do',
        child: Text(
          'To do',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
      const PopupMenuItem<String>(
        value: 'In Progress',
        child: Text(
          'In Progress',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
      const PopupMenuItem<String>(
        value: 'Done',
        child: Text(
          'Done',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
       const PopupMenuItem<String>(
        value: 'Bug',
        child: Text(
          'Bug',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
    ],
    icon: const Icon(Icons.more_vert, color: Colors.white), // Set the icon color to white
    color: Colors.black, // Set the background color of the popup menu to black
  ),
],

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!.docs.map((doc) {
            return Task.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Apply filtering based on selected status
          List<Task> filteredTasks = tasks;
          if (_selectedStatus != 'All') {
            print(_selectedStatus);
            filteredTasks = tasks.where((task) => task.status == _selectedStatus).toList();
            // print(filteredTasks);
          }

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              return TaskItem(task: filteredTasks[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
