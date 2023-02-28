import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:todo/components/dialog_add.dart';
import 'package:todo/data/database.dart';
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
      showSnackbar();
    } else {
      setState(() {
        db.todoList.add([_controller.text, false]);
      });
      db.updateDatabase();
      Navigator.pop(context);
      _controller.clear();
    }
  }

  void fabClicked() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd(
          controller: _controller,
          onSave: saveTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  //Delete task
  void deleteTask(int index) {
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
          fabClicked();
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

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Você não pode salvar uma tarefa vazia!'),
      ),
    );
  }
}
