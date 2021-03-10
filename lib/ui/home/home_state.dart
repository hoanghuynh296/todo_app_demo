import 'dart:ffi';

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:todo_app/data/model/TodoModel.dart';

class AppError {
  String message;
  String code;
}

abstract class IHaveLoading {
  bool isLoading = false;
}

abstract class ICanLoadData {
  AppError error = null;
}

abstract class ICanCopy<T> {
  T copy({setParams(T result)});
}

abstract class BaseState<T> implements ICanCopy<T> {}

class HomeState extends BaseState<HomeState> with IHaveLoading, ICanLoadData {
  List<TaskModel> data;
  @override
  HomeState copy({Function(HomeState result) setParams}) {
    var result = HomeState();
    result.isLoading = this.isLoading;
    result.error = this.error;
    result.data = this.data;
    setParams(result);
    return result;
  }

  void test() {
    copy(
        setParams: (result) => {
              result
                ..error = null
                ..isLoading = false
            });
  }
}
