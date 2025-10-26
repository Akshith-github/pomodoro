import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/data/database/app_database.dart';
import 'package:pomodoro/providers/complete_pomodoro_provider.dart';
import 'package:pomodoro/ui/components/consumer_timer_widget.dart';

class TimerScreen extends HookConsumerWidget {
  static const int durationInSeconds = 5; // For testing, set to 5 seconds
  final Task task;
  const TimerScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: durationInSeconds),
    );
    final animation = useAnimation(controller);

    ref.listen(completePomodoroProvider, (previous, next) {
      if (next.isCompleted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Pomodoro Completed!')));
        Navigator.pop(context);
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Timer Screen', style: Theme.of(context).textTheme.bodyLarge),
            CustomTimerWidget(
              progress: animation,
              remainingTime: _getRemainingTime(controller),
              label: task.title,
              onTap: () {
                _toggleTimer(controller, ref, task.id);
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _toggleTimer(controller, ref, task.id);
                  },
                  icon: Icon(
                    controller.isAnimating ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    controller.reset();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRemainingTime(Animation controller) {
    log('Controller value: ${controller.value} ');
    final remainingTime =
        Duration(seconds: durationInSeconds) * (1 - controller.value);
    return '${remainingTime.inMinutes.toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _toggleTimer(AnimationController controller, WidgetRef ref, int taskId) {
    if (controller.isAnimating) {
      controller.stop();
      log('Timer paused at ${controller.value}');
    } else {
      controller.forward().whenComplete(() {
        log('Timer completed');
        ref.read(completePomodoroProvider.notifier).completePomodoro(taskId);
        // You can add additional logic here, e.g., notify the user
      });
    }
  }
}
