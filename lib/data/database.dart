import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  //Reference the box
  final _myBox = Hive.box('myBox');

  //Initial default data
  void createInitialData() {
    todoList = [
      ['Realizar anotações', false],
      ['Abrir o App', true]
    ];
  }

  //Load data from db
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  //Update data from db
  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
