import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/providers/add_task_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  int _pomodoroCount = 1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addTaskState = ref.watch(addTaskProvider);
    ref.listen(addTaskProvider, (previousState, nextState) {
      if (nextState.isSuccess) {
        Navigator.pop(context);
      } else if (nextState.isError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Error adding task')));
      }
    });

    final theme = Theme.of(context);
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            tooltip: 'Close',
          ),
          actions: [
            TextButton(
              // tooltip: 'Save Task',
              onPressed: addTaskState.isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(addTaskProvider.notifier)
                            .addTask(_titleController.text, _pomodoroCount);
                      }
                    },
              child: Text(
                addTaskState.isLoading ? 'Saving...' : 'Save',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Title
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  // Task Icon & Color
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Task Icon & Color'),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            spacing: 16.0,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                child: const Icon(
                                  Icons.work,
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Choose Icon'),
                                            content: Text(
                                              'Icon picker goes here',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Row(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: theme.colorScheme.primary,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          'Choose Icon',
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Row(
                                      children: [
                                        Icon(
                                          Icons.color_lens,
                                          color: theme.colorScheme.primary,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          'Choose Color',
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Pomodoro Count
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number of Pomodoros'),
                      Card(
                        child: Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16.0,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_pomodoroCount > 1) {
                                    _pomodoroCount--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(
                              '$_pomodoroCount',
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _pomodoroCount++;
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tags'),
                      Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 4.0,
                          children: [
                            Card(
                              color: Colors.deepPurple,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Tag 1 text long'),
                              ),
                            ),
                            Card(
                              color: Colors.brown,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Tag 2'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
