import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';
import '../components/add_sheet_content.dart';
import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Reference the hive box
  final _myBox = Hive.box('myBox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    //If it is the first time opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //If already has data stored
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  // Checkbox when clicked
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  //Save a task
  void saveTask() {
    if (_controller.text.isEmpty) {
      return;
    } else {
      setState(() {
        db.todoList.add([_controller.text, false]);
      });
      db.updateDatabase();
      Navigator.pop(context);

      showSnackbar('Tarefa ${_controller.text} adicionada.');
      _controller.clear();
    }
  }

  //Delete task
  void deleteTask(int index) {
    showSnackbar('Tarefa ${db.todoList[index][0]} deletada.');
    setState(() {
      db.todoList.removeAt(index);
    });

    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        title: const Text(
          'TO DO',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddSheet();
        },
        child: const Icon(Icons.add),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1075),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: TodoTile(
                    deleteFunc: (context) => deleteTask(index),
                    taskName: db.todoList[index][0],
                    taskCompleted: db.todoList[index][1],
                    onChanged: (value) {
                      checkBoxChanged(value, index);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void showAddSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddSheetContent(
            controller: _controller,
            onSave: () => saveTask(),
            onCancel: () => Navigator.pop(context),
          ),
        );
      },
    );
  }
}
