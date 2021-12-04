import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'package:todo_app/view_model/todo_screen_view_model.dart';

class AddTodoTaskWidget extends StatefulWidget {
  @override
  State<AddTodoTaskWidget> createState() => _AddTodoTaskWidgetState();
}

class _AddTodoTaskWidgetState extends State<AddTodoTaskWidget> {
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descrpController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  String title = '';

  String description = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25.0),
            Form(
              key: formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'enter your task',
                  prefixIcon: const Icon(Icons.title),
                ),
                controller: titleController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Task Title';
                  }
                  return null;
                },
                onChanged: (value) {
                  title = value;
                },
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Description',
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.description),
                  ],
                ),
              ),
              maxLines: 3,
              minLines: 3,
              controller: descrpController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Task Description';
                }
                return null;
              },
              onChanged: (String? value) {
                description = value!;
              },
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'select date',
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: dateController,
                    onTap: () {
                      TodoViewModel.showSelectedDate(
                        context,
                        dateController,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'select time',
                      prefixIcon: const Icon(Icons.schedule),
                    ),
                    controller: timeController,
                    onChanged: (value) {
                      timeController.text = value;
                    },
                    onTap: () {
                      TodoViewModel.showSelectTime(
                        context,
                        timeController,
                        // selectedTime,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyThemeData.primaryColor),
              child: MaterialButton(
                onPressed: () {
                  TodoViewModel.addtodo(
                    context,
                    formKey,
                    title,
                    description,
                    dateController.text,
                    timeController.text,
                  );
                  provider.todoItems();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
