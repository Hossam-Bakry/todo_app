import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/shared/network/remote/firestore_utils.dart';

class AppProvider extends ChangeNotifier {
  List<Todo> items = [];
  String selectedDate = DateFormat.yMMMd().format(DateTime.now());

  void todoItems() {
    FirestroeUtils.getTodosCollectionWithConvert()
        .where('date', isEqualTo: selectedDate)
        .get()
        .then((document) {
      items = document.docs.map((element) {
        return element.data();
      }).toList();
      notifyListeners();
    });
  }

  void setNewDate(String selectedDate) {
    this.selectedDate = selectedDate;
    notifyListeners();
  }

  ThemeMode appThemeMode = ThemeMode.light;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  void changeThemeMode(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (appThemeMode == mode) {
      return;
    } else {
      appThemeMode = mode;
    }
    prefs.setString('theme', mode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }
}
