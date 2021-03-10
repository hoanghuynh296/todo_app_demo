import 'package:todo_app/data/IAmTodoRepository.dart';
import 'package:todo_app/data/model/TodoModel.dart';

class TodoRepository extends IAmTodoRepository {
  static final TodoRepository _singleton = TodoRepository._internal();

  factory TodoRepository() {
    return _singleton;
  }

  TodoRepository._internal();

  var _mockData = Map.fromEntries(List.generate(
      10,
      (index) =>
          MapEntry("id$index", TaskModel.create("id$index", "Task todo $index"))));

  @override
  Future<List<TaskModel>> getAll() {
    return Future.value(_mockData.values.toList());
  }

  @override
  Future<TaskModel> update(TaskModel data) {
    _mockData[data.id] = data;
    return Future.value(data);
  }
}
