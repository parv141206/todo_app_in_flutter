import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  final Function addTodo;

  const AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final titleController = TextEditingController();
  final todoTextController = TextEditingController();
  TimeOfDay todoTime = TimeOfDay.now();
  DateTime todoDate = DateTime.now();
  void _showTimePickerDialog() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    this.todoTime = pickedTime!;
    if (pickedTime != null) {
      // Do something with the selected time
      print('Selected time: $pickedTime');
    }
  }

  void _showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
    this.todoDate = pickedDate!;
    if (pickedDate != null) {
      // Do something with the selected time
      print('Selected time: $pickedDate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Title",
                border: UnderlineInputBorder(),
              ),
              controller: titleController,
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Description",
                border: UnderlineInputBorder(),
              ),
              controller: todoTextController,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: _showTimePickerDialog,
              child: const Text("Select time"),
            ),
            ElevatedButton(
              onPressed: _showDatePickerDialog,
              child: const Text("Select date"),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                widget.addTodo(titleController.text, todoTextController.text,
                    todoTime, todoDate);
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
