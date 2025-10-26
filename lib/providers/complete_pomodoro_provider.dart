import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/data/repository/task_repository.dart';

class CompletePomodoroState {
  final bool isCompleted;

  CompletePomodoroState({required this.isCompleted});
}

class CompletePomodoroProvider extends Notifier<CompletePomodoroState> {
  @override
  CompletePomodoroState build() {
    return CompletePomodoroState(isCompleted: false);
  }

  Future<void> completePomodoro(int taskId) async {
    // state = CompletePomodoroState(isCompleted: true);
    // mark pomodoro as complete in the database
    final taskRepository = ref.read(taskRepositoryProvider);
    await taskRepository.completePomodoro(taskId);
    state = CompletePomodoroState(isCompleted: true);
  }
}

final completePomodoroProvider =
    NotifierProvider<CompletePomodoroProvider, CompletePomodoroState>(
      () => CompletePomodoroProvider(),
    );
