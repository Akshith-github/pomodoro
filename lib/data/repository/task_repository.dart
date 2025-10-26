import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/data/database/app_database.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return TaskRepository(database);
});

class TaskRepository {
  final AppDatabase _database;

  TaskRepository(this._database);

  Future<List<Task>> getAllTasks() async {
    return await _database.getAllTasks();
  }

  Future<Task> getTaskById(int id) async {
    return await _database.getTaskById(id);
  }

  Future<int> createTask(String title, int pomodoroCount) async {
    return await _database.createTask(
      TasksCompanion.insert(
        title: title,
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        pomodoroCount: Value(pomodoroCount),
      ),
    );
  }

  Stream<List<Task>> watchTodayTasks(DateTime start, DateTime end) {
    final query = _database.select(_database.tasks);
    query.where((tbl) => tbl.createdAt.isBetweenValues(start, end));
    return query.watch();
  }

  Future<void> completePomodoro(int taskId) async {
    final task = await getTaskById(taskId);
    await _database.updateTask(
      task
          .toCompanion(true)
          .copyWith(
            completedPomodoros: Value(task.completedPomodoros + 1),
            updatedAt: Value(DateTime.now()),
            isDone: Value(task.completedPomodoros >= task.pomodoroCount),
          ),
    );
  }
}
