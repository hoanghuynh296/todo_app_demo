import 'package:todo_app/data/model/TodoModel.dart';
import 'package:todo_app/data/model/TodoStatus.dart';

abstract class IAmSetTaskStatusEvent {
  TaskModel task;
}

class SetTaskDoneEvent extends IAmSetTaskStatusEvent {
  SetTaskDoneEvent(TaskModel task) {
    this.task = task;
  }
}

class SetTaskNewEvent extends IAmSetTaskStatusEvent {
  SetTaskNewEvent(TaskModel task) {
    this.task = task;
  }
}

class GetDataEvent {}
