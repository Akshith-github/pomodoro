import 'package:flutter/material.dart';
import 'package:pomodoro/ui/components/task_list.dart';
import 'package:pomodoro/ui/components/today_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add task screen
          Navigator.pushNamed(context, '/addTask');
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(16.0), child: TodaySummary()),
            const Text('Welcome to the Pomodoro App!'),
            const SizedBox(height: 20),
            const Expanded(child: TaskList()),
          ],
        ),
      ),
    );
  }
}
