import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro/data/repository/task_repository.dart';
import 'package:pomodoro/data/database/app_database.dart';

final taskListStreamProvider = StreamProvider<List<Task>>((ref) {
  final taskRepository = ref.watch(taskRepositoryProvider);
  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day);
  final end = DateTime(today.year, today.month, today.day + 1);
  return taskRepository.watchTodayTasks(start, end);
});
