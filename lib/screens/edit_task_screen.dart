import 'package:flutter/material.dart';
import 'package:my_first_flutter_application_/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _selectedStatus;

  final List<String> _statuses =  ['To Do', 'In Progress', 'Done', 'Bug'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _selectedStatus = widget.task.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier Tache'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Titre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: null, // Allows the TextField to expand vertically
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedStatus,
              items: _statuses.map((String status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
          Container(
  width: double.infinity, // Make button full width
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.black, // Background color
    borderRadius: BorderRadius.circular(12),
  ),
  child: ElevatedButton(
    onPressed: () async {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final updatedTask = Task(
        id: widget.task.id,
        title: title,
        description: description,
        status: _selectedStatus,
      );

      // Update task in Firestore
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(updatedTask.id)
          .update(updatedTask.toMap());

      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, 
      backgroundColor: Colors.black, // Text color
      padding: EdgeInsets.zero, // No padding from the ElevatedButton itself
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Padding inside the button
      child: const Text(
        'Mettre a jour Tache',
        style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 16,
        ),
      ),
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}
