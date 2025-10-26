import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pomodoro/data/database/app_database.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  const TaskCard({super.key, required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    int completedPomodoros = task.completedPomodoros;
    log('Completed Pomodoros: $completedPomodoros');
    log('Total Pomodoros: ${task.pomodoroCount}');
    log('Task done: ${task.isDone}');
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.add_task, color: Theme.of(context).primaryColor),
          // strike off if completed
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          // subtitle: Text('Pomodoros: ${task.pomodoroCount}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              task.pomodoroCount,
              (index) => Icon(
                Icons.timer,
                color: index < completedPomodoros ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
