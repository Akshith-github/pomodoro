import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

part 'app_database.g.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  IntColumn get pomodoroCount => integer().withDefault(const Constant(0))();
  IntColumn get completedPomodoros =>
      integer().withDefault(const Constant(0))();
}

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Future<int> createTask(TasksCompanion task) => into(tasks).insert(task);

  Future<Task> getTaskById(int id) async {
    return await (select(tasks)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<void> updateTask(TasksCompanion task) => update(tasks).replace(task);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final db = await path_provider.getApplicationDocumentsDirectory();
    final file = File(path.join(db.path, 'pomodoro.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
