import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/shared/network/remote/firestore_utils.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'package:todo_app/view_model/todo_screen_view_model.dart';

class EditTaskWidget extends StatefulWidget {
  Todo item;
  Function onClick;

  EditTaskWidget(this.item, this.onClick);

  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  var formEditKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descrpController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
        child: Form(
          key: formEditKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Edit Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
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
                onChanged: (String value) {
                  if (value != null && value.isNotEmpty) {
                    FirestroeUtils.updateTask(
                            item: widget.item, key: 'title', value: value)
                        .then((value) {});
                    widget.item.title = value;
                  }
                  provider.todoItems();
                },
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
                onChanged: (String value) {
                  if (value != null && value.isNotEmpty) {
                    FirestroeUtils.updateTask(
                            item: widget.item, key: 'description', value: value)
                        .then((value) {});
                    widget.item.description = value;
                  }
                  provider.todoItems();
                },
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'select date',
                        prefixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: dateController,
                      onTap: () {
                        widget.item.date = dateController.text;
                        TodoViewModel.showSelectedDate(
                          context,
                          dateController,
                        );
                      },
                      onChanged: (String value) {
                        if (value != null && value.isNotEmpty) {
                          FirestroeUtils.updateTask(
                                  item: widget.item, key: 'date', value: value)
                              .then((value) {});
                          widget.item.date = value;
                        }
                        provider.todoItems();
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'select time',
                        prefixIcon: const Icon(Icons.schedule),
                      ),
                      controller: timeController,
                      onTap: () {
                        widget.item.time = timeController.text;
                        TodoViewModel.showSelectTime(
                          context,
                          timeController,
                          // selectedTime,
                        );
                      },
                      onChanged: (String value) {
                        if (value != null && value.isNotEmpty) {
                          FirestroeUtils.updateTask(
                                  item: widget.item, key: 'time', value: value)
                              .then((value) {});
                          widget.item.time = value;
                        }
                        provider.todoItems();
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
                    if (formEditKey.currentState!.validate()) {
                      widget.onClick(widget.item);
                      provider.todoItems();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Save Changes',
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
      ),
    );
  }
}
