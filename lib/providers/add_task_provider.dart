import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pomodoro/data/repository/task_repository.dart';

class AddTaskState {
  final bool isSuccess;
  final bool isLoading;
  final bool isError;

  AddTaskState({
    this.isSuccess = false,
    this.isLoading = false,
    this.isError = false,
  });
}

class AddTaskNotifier extends Notifier<AddTaskState> {
  @override
  AddTaskState build() {
    return AddTaskState(); // Initial state
  }

  Future<void> addTask(String title, int pomodoroCount) async {
    final _taskRepository = ref.read(taskRepositoryProvider);
    state = AddTaskState(isLoading: true);
    final taskId = await _taskRepository.createTask(title, pomodoroCount);
    if (taskId > 0) {
      state = AddTaskState(isSuccess: true, isLoading: false);
    } else {
      state = AddTaskState(isError: true, isLoading: false);
    }
  }
}

final addTaskProvider = NotifierProvider.autoDispose<AddTaskNotifier, AddTaskState>(
  AddTaskNotifier.new,
);
