import 'package:flutter/material.dart';
import 'graphql_task_service.dart';
import 'add_edit_task_form.dart';

// Widget to manage the todo list. Its defined as stateful so the app responds
// to updates dynamically.
class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

// State class of our todo list screen
class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> _todoList = [];

  // Initialize state of the widget
  @override
  void initState() {
    super.initState();
    
    _fetchTodoList();
  }

  // Gets the todo list
  Future<void> _fetchTodoList() async {
    final todoList = await fetchTodoList();
    setState(() {
      _todoList = todoList;
    });
  }

  // Delete task from todo list
  Future<void> _deleteTask(String taskId) async {
    await deleteTask(taskId);
    _fetchTodoList(); // Refresh todo list
  }

  // Function to build out add/edit form as a bottom sheet popup
  void _showTaskForm([Map<String, dynamic>? task]) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TaskForm(
          task: task,
          onSubmit: (newTask) async {
            // Callback to handle form submission
            if (task == null) {
              await addTask(newTask);
            } else {
              newTask['id'] = task['id'];
              await updateTask(newTask);
            }
            _fetchTodoList(); // Refresh todo list
          },
        );
      },
    );
  }

  // Build our widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3.5,
        ),
        itemCount: _todoList.length,
        itemBuilder: (BuildContext context, int index) {
          final task = _todoList[index];
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // If task complete, show check mark icon
                      if (task['completed'] == true) 
                        const Icon(Icons.check_circle, color: Colors.green, size: 20),
                      if (task['completed'] == true)
                        const SizedBox(width: 8), // Space between icon and title
                      Expanded(
                        child: Text(
                          task['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Ellipsis if title too long
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Space between title and description
                  Text(
                    task['description']+'\n' ?? '',
                    maxLines: 2, // Limit description span
                    overflow: TextOverflow.ellipsis, // Fade text when description gets too long
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8), // Space between description and buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Edit button
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showTaskForm(task),
                      ),
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTask(task['id']),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Floating action button shows form for adding tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskForm(),
        child: const Icon(Icons.add),
      ),
    );
  }

}