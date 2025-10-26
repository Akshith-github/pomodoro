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

  Future<int> createTask(Task task) async {
    return await _database.createTask(
      TasksCompanion.insert(
        title: task.title,
        createdAt: Value(task.createdAt),
        updatedAt: Value(task.updatedAt),
        deletedAt: Value(task.deletedAt),
        isDone: Value(task.isDone),
        pomodoroCount: Value(task.pomodoroCount),
      ),
    );
  }

  Stream<List<Task>> watchTodayTasks(DateTime start, DateTime end) {
    final query = _database.select(_database.tasks);
    query.where((tbl) => tbl.createdAt.isBetweenValues(start, end));
    return query.watch();
  }
}
