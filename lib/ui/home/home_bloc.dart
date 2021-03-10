import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/IAmTodoRepository.dart';
import 'package:todo_app/data/TodoRepository.dart';
import 'package:todo_app/ui/home/home_event.dart';

import './home_state.dart';

class HomeBloc extends Bloc<dynamic, HomeState> {
  HomeBloc() : super(HomeState());
  IAmTodoRepository _todoRepository = TodoRepository();

  @override
  Stream<HomeState> mapEventToState(dynamic event) async* {
    _notifyShowLoading(state);
    if (event is GetDataEvent) {
      var items = await _todoRepository.getAll();
      yield state.copy(setParams: (r) => {r.isLoading = false, r.data = items});
    } else if (event is SetTaskDoneEvent) {
      event.task.setToDone();
      await _todoRepository.update(event.task);
      yield state.copy(setParams: (r) => {r.isLoading = false});
    } else if (event is SetTaskNewEvent) {
      event.task.setToNew();
      await _todoRepository.update(event.task);
      yield state.copy(setParams: (r) => {r.isLoading = false});
    }
  }

  Stream<HomeState> _notifyShowLoading(HomeState state) async* {
    yield state.copy(setParams: (r) => {r.isLoading = true});
  }
}
