import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/data/database/app_database.dart';
import 'package:pomodoro/data/repository/task_repository.dart';

final todayTasksProvider = StreamProvider<List<Task>>((ref) async* {
  final taskRepository = ref.watch(taskRepositoryProvider);
  final today = DateTime.now();
  final start = DateTime(today.year, today.month, today.day);
  final end = DateTime(today.year, today.month, today.day + 1);
  yield* taskRepository.watchTodayTasks(start, end);
});

final todaySummaryProvider = StreamProvider<(int, int)>((ref) async* {
  final todayTasks = ref.watch(todayTasksProvider);
  yield (
    todayTasks.value?.length ?? 0,
    todayTasks.value?.where((task) => task.isDone).length ?? 0,
  );
});
