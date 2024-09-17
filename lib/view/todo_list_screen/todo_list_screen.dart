import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/view/todo_list_screen/todo_item_widget.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  DatePickerController dateController = DatePickerController();
  DateTime selectDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    provider.todoItems();

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
                    color: provider.appThemeMode == ThemeMode.dark
                        ? Colors.black.withOpacity(0.1)
                        : Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: provider.appThemeMode == ThemeMode.dark
                            ? Colors.black.withOpacity(0.1)
                            : Colors.white.withOpacity(0.3),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: DatePicker(
                    DateTime.now().subtract(
                      const Duration(days: 3),
                    ),
                    height: 80,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: provider.appThemeMode == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                    selectedTextColor: provider.appThemeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    controller: dateController,
                    onDateChange: (date) {
                      provider.setNewDate(DateFormat.yMMMd().format(date));
                      provider.todoItems();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * .04),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext buildContext, int index) =>
                TodoItem(provider.items[index]),
            itemCount: provider.items.length,
          ),
        ),
      ],
    );
  }
}
