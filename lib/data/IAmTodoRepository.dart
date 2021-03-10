import 'package:todo_app/data/model/TodoModel.dart';

abstract class IAmTodoRepository {
  Future<List<TaskModel>> getAll();

  Future<TaskModel> update(TaskModel data);
}
