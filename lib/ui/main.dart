import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/home_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          body: TabBarView(
            children: [
              HomeWidget(ListMode.ALL),
              HomeWidget(ListMode.NEW),
              HomeWidget(ListMode.DONE)
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.blue,
            child: TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'New'),
                Tab(text: 'Done'),
              ],
            ),
          )),
    );
  }
}
