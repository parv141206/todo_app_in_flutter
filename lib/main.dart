import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/home.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodosFromDevice();
  }

  loadTodosFromDevice() async {
    final ref = await SharedPreferences.getInstance();
    final todosReadFromDisk = ref.getString("todos");
    if (todosReadFromDisk != null) {
      try {
        setState(() {
          todos =
              List<Map<String, dynamic>>.from(jsonDecode(todosReadFromDisk));
        });
      } catch (e) {
        print("Error decoding todos: $e");
      }
    }
  }

  storeTodoOnDevice(todo) async {
    final ref = await SharedPreferences.getInstance();
    // todos.add(todo);
    ref.setString("todos", jsonEncode(todos));
  }

  addTodo(todoTitle, todoText, todoTime, todoDate) async {
    final todo_object = {
      "todoTitle": todoTitle,
      "todoText": todoText,
      "todoTime": {
        "hour": todoTime.hour,
        "minute": todoTime.minute,
      },
      "todoDate": {"day": todoDate.day}
    };
    print("_______________________________________");
    print(todo_object);
    setState(() {
      // todos.clear();
      todos.add(todo_object);
    });
    await Alarm.init();
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          todo_object["todoDate"]["day"],
          todo_object["todoTime"]["hour"],
          todo_object["todoTime"]["minute"]),
      assetAudioPath: 'assets/alarm.mp3',
      volume: 0.8,
      notificationTitle: 'Alarm example',
      notificationBody: 'Shortcut button alarm with delay of hours',
      // enableNotificationOnKill: Platform.isIOS,
    );
    await Alarm.set(alarmSettings: alarmSettings);
    storeTodoOnDevice(todo_object);
  }

  deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
    saveTodosToDisk(todos);
  }

  saveTodosToDisk(List<Map<String, dynamic>> todos) async {
    final SharedPreferences ref = await SharedPreferences.getInstance();
    ref.setString("todos", jsonEncode(todos));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        toolbarHeight: 80,
        actions: [
          ElevatedButton(
              onPressed: () async {
                await Alarm.init();
                await Alarm.stop(42);
                await Alarm.stopAll();
              },
              child: Text("delete alarm"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTodo(addTodo: addTodo)));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
        child: Home(
          todos: todos,
          addTodo: addTodo,
          deleteTodo: deleteTodo,
        ),
      ),
    );
  }
}
