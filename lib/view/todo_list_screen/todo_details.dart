import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/view_model/todo_screen_view_model.dart';

class TodoDetails extends StatelessWidget {
  static const String routeName = 'todo details';
  Todo item;

  TodoDetails(this.item);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<AppProvider>(context);
    provider.todoItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: provider.appThemeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              TodoViewModel.showEditTaskSheet(context, item, onClik);
            },
            icon: const Icon(
              Icons.border_color,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: const Color.fromRGBO(93, 156, 236, 1),
                  width: double.infinity,
                  height: size.height / 10,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.75,
                  margin: EdgeInsets.only(
                    left: size.width * 0.065,
                    right: size.width * 0.065,
                    top: size.height * 0.035,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  alignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: provider.appThemeMode == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: provider.appThemeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: provider.appThemeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 15, right: 40),
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.black26,
                      ),
                      Text(
                        item.description,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: provider.appThemeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: provider.appThemeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 15, right: 40),
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.black26,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.today,
                                color: provider.appThemeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item.date,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: provider.appThemeMode == ThemeMode.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: provider.appThemeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item.time,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: provider.appThemeMode == ThemeMode.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onClik(Todo item) {
    this.item = item;
  }
}
