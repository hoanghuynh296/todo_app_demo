import 'TodoStatus.dart';

class TaskModel {
  String id;
  String title;
  TaskStatus status;

  TaskModel(this.id, this.title, {this.status});

  void setToDone() {
    status = TaskStatus.DONE;
  }

  void setToNew() {
    status = TaskStatus.NEW;
  }

  bool isNew() {
    return status == TaskStatus.NEW;
  }

  bool isDone() {
    return status == TaskStatus.DONE;
  }

  static TaskModel create(String id, String title) =>
      TaskModel(id, title, status: TaskStatus.NEW);
}
