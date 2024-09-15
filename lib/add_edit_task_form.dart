import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final Map<String, dynamic>? task;
  final Function(Map<String, dynamic>) onSubmit;

  const TaskForm({this.task, required this.onSubmit});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize form fields
    _titleController = TextEditingController(text: widget.task?['title'] ?? '');
    _descriptionController = TextEditingController(text: widget.task?['description'] ?? '');
    _completed = widget.task?['completed'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Title text field
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),

          // Description text field
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),

          // Checkbox for completion
          if (widget.task != null)
          Row(
            children: <Widget>[
              const Text('Completed'),
              Checkbox(
                value: _completed,
                onChanged: (bool? value) {
                  setState(() {
                    _completed = value ?? false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              final task = {
                'title': _titleController.text,
                'description': _descriptionController.text,
                'completed': _completed,
              };

              // Add task id if editing
              if (widget.task != null) {
                task['id'] = widget.task!['id'];
              }

              widget.onSubmit(task);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}