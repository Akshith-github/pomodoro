import 'package:flutter/material.dart';
import 'package:pomodoro/ui/components/today_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(padding: EdgeInsets.all(16.0), child: TodaySummary()),
            Text('Welcome to the Pomodoro App!'),
          ],
        ),
      ),
    );
  }
}
