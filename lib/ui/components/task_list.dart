import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/providers/today_tasks_provider.dart';
import 'package:pomodoro/ui/components/task_card.dart';
import 'package:pomodoro/ui/screens/timer_screen.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todayTasksProvider);
    return tasks.when(
      data: (tasks) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(
              task: task,
              onTap: () {
                // Handle task tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(task: task),
                  ),
                );
              },
            );
          },
        );
      },
      loading: () =>
          Container(height: 100, child: const CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
