// todo_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoCard extends StatelessWidget {
  final String todoTitle;
  final String todoText;
  final String todoTime;
  final int index;
  final Function(int) deleteTodo;
  const TodoCard({
    super.key,
    required this.deleteTodo,
    required this.index,
    required this.todoTitle,
    required this.todoText,
    required this.todoTime,
  });
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 247, 250, 252),
              borderRadius: BorderRadius.all(Radius.circular(14)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Color.fromARGB(255, 237, 237, 237),
                    offset: Offset(0, 6))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todoTitle,
                  style: TextStyle(fontSize: 18),
                ),
                Text(todoText),
                Text(
                  todoTime,
                  style: TextStyle(
                      fontSize: 12, color: const Color.fromARGB(103, 0, 0, 0)),
                ),
                ElevatedButton(
                    onPressed: () => deleteTodo(index),
                    child: Text("Delete todo"))
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
