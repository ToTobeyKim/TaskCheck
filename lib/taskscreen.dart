import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/main.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final CollectionReference _tasks = FirebaseFirestore.instance.collection('tasks');
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _subtaskController = TextEditingController();

  Future<void> _addOrEditTask([DocumentSnapshot? taskDoc]) async {
    String action = 'Add';
    if (taskDoc != null) {
      action = 'Edit';
      _taskController.text = taskDoc['name'];
    }

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(action + ' Task'),
                onPressed: () async {
                  if (_taskController.text.isNotEmpty) {
                    if (action == 'Add') {
                      await _tasks.add({
                        "name": _taskController.text,
                        "completed": false,
                        "subtasks": []
                      });
                    } else {
                      await _tasks.doc(taskDoc!.id).update({
                        "name": _taskController.text,
                      });
                    }
                    _taskController.clear();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addOrEditSubtask(DocumentSnapshot taskDoc, [int? index]) async {
    String action = 'Add';
    if (index != null) {
      action = 'Edit';
      _subtaskController.text = taskDoc['subtasks'][index]['name'];
    }

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _subtaskController,
                decoration: InputDecoration(labelText: 'Subtask Name'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(action + ' Subtask'),
                onPressed: () async {
                  if (_subtaskController.text.isNotEmpty) {
                    List subtasks = taskDoc['subtasks'] ?? [];

                    if (action == 'Add') {
                      subtasks.add({
                        "name": _subtaskController.text,
                        "completed": false,
                      });
                    } else {
                      subtasks[index!]['name'] = _subtaskController.text;
                    }

                    await _tasks.doc(taskDoc.id).update({"subtasks": subtasks});
                    _subtaskController.clear();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _toggleTaskDone(DocumentSnapshot taskDoc) async {
    await _tasks.doc(taskDoc.id).update({"completed": !taskDoc["completed"]});
  }

  Future<void> _toggleSubtaskDone(DocumentSnapshot taskDoc, int index) async {
    List subtasks = taskDoc['subtasks'];
    subtasks[index]['completed'] = !subtasks[index]['completed'];
    await _tasks.doc(taskDoc.id).update({"subtasks": subtasks});
  }

  Future<void> _deleteTask(String taskId) async {
    await _tasks.doc(taskId).delete();
  }

  Future<void> _logout() async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyApp()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: _logout)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tasks.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((taskDoc) {
              List subtasks = taskDoc["subtasks"];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(taskDoc["name"]),
                  leading: Checkbox(
                    value: taskDoc["completed"],
                    onChanged: (_) => _toggleTaskDone(taskDoc),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _addOrEditSubtask(taskDoc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTask(taskDoc.id),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: subtasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      var subtask = entry.value;
                      return ListTile(
                        title: Text(subtask['name']),
                        leading: Checkbox(
                          value: subtask['completed'],
                          onChanged: (_) => _toggleSubtaskDone(taskDoc, index),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTask(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
