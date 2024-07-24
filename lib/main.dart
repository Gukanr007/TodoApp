// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo List",
        debugShowCheckedModeBanner: false,
        home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItem = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItem.add(task);
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItem.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Mark ${_todoItem[index]} is Done"),
            actions: <Widget>[
              FloatingActionButton(
                  child: Text("Cancel"),
                  onPressed: () => {Navigator.of(context).pop()}),
              FloatingActionButton(
                  child: Text("Ok"),
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItem.length) {
          return _buildTodoItem(_todoItem[index], index);
        }
        return null;
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () {
        _promptRemoveTodoItem(index);
      },
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add a New Task"),
            backgroundColor: Colors.cyan,
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (value) {
              _addTodoItem(value);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: "Enter the Task", contentPadding: EdgeInsets.all(16)),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        backgroundColor: Colors.cyan,
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: "Add Task",
        child: Icon(Icons.add),
      ),
    );
  }
}
