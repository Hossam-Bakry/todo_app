import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/view/todo_list_screen/todo_item_widget.dart';
import 'package:todo_app/view_model/firestore_utils.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  DatePickerController dateController = DatePickerController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: const Color.fromRGBO(93, 156, 236, 1),
          height: size.height / 10,
          child: Stack(
            alignment: Alignment(0, size.height / 60),
            children: [
              Positioned(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: DatePicker(
                    DateTime.now().subtract(
                      const Duration(days: 2),
                    ),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.white,
                    selectedTextColor: Colors.black,
                    controller: dateController,
                    onDateChange: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    height: 80,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * .04),
        Expanded(
          child: FutureBuilder<QuerySnapshot<Todo>>(
            builder: (BuildContext buildContext,
                AsyncSnapshot<QuerySnapshot<Todo>> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // loading
                return const Center(child: CircularProgressIndicator());
              }
              // data is ready
              List<Todo> items =
                  snapshot.data!.docs.map((element) => element.data()).toList();
              return ListView.builder(
                itemBuilder: (BuildContext buildContext, int index) {
                  return TodoItem(items[index]);
                },
                itemCount: items.length,
              );
            },
            future: FirestroeUtils.getTodosCollection().get(),
          ),
        ),
      ],
    );
  }
}
