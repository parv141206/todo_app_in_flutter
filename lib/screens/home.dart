import 'package:flutter/material.dart';
import 'package:todo_app/components/todo_card.dart';

class Home extends StatefulWidget {
  final List<Map<String, dynamic>> todos;
  final dynamic Function(int) deleteTodo;

  const Home(
      {super.key,
      required this.todos,
      required this.deleteTodo,
      required Function(dynamic todoTitle, dynamic todoText, dynamic todoTime,
              dynamic todoDate)
          addTodo});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                textAlign: TextAlign.center,
                "Have a look at your todos!",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.todos.length,
              itemBuilder: (context, index) {
                return TodoCard(
                  index: index,
                  deleteTodo: widget.deleteTodo,
                  todoTitle: widget.todos[index]["todoTitle"] ?? "",
                  todoText: widget.todos[index]["todoText"] ?? "",
                  todoTime:
                      '${widget.todos[index]["todoTime"]["hour"] ?? ""}:${widget.todos[index]["todoTime"]["minute"] ?? ""} on ${widget.todos[index]["todoDate"]["day"]}/${DateTime.now().month}/${DateTime.now().year}',
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 24);
              },
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
