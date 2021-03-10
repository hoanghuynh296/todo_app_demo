import 'package:flutter/material.dart';
import 'package:todo_app/data/model/TodoModel.dart';
import 'package:todo_app/ui/home/home_event.dart';
import './home_bloc.dart';
import './home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ListMode { ALL, NEW, DONE }

class HomeWidget extends StatefulWidget {
  final ListMode mode;

  HomeWidget(this.mode);

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Bloc _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _builder());
  }

  Widget _builder() {
    return BlocBuilder<HomeBloc, HomeState>(
        cubit: _bloc,
        builder: (buildContext, state) {
          return _buildBody(buildContext, state);
        });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() {
    _bloc.add(GetDataEvent());
  }

  void _setTaskDone(TaskModel task) {
    _bloc.add(SetTaskDoneEvent(task));
  }

  void _setTaskNew(TaskModel task) {
    _bloc.add(SetTaskNewEvent(task));
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    return Scaffold(
      body: () {
        if (state.isLoading) {
          return CircularProgressIndicator();
        } else {
          return () {
            if (state.data == null || state.data.isEmpty) {
              return Text('No data');
            } else {
              var items = state.data
                  .where((element) => () {
                        if (widget.mode == ListMode.ALL)
                          return true;
                        else if (widget.mode == ListMode.NEW)
                          return element.isNew();
                        else
                          return element.isDone();
                      }())
                  .toList();
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = items[index];
                    return Container(
                      padding: EdgeInsets.all(12),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            item.title,
                            style: TextStyle(decoration: () {
                              if (item.isDone())
                                return TextDecoration.lineThrough;
                              else
                                return TextDecoration.none;
                            }()),
                          )),
                          Checkbox(
                              activeColor: Colors.blue,
                              checkColor: Colors.white,
                              value: item.isDone(),
                              onChanged: (isCheck) {
                                if (isCheck) {
                                  _setTaskDone(item);
                                } else
                                  _setTaskNew(item);
                              })
                        ],
                      ),
                    );
                  });
            }
          }();
        }
      }(),
    );
  }
}
