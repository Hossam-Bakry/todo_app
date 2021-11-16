import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/view/todo_list_screen/add_todo_widget.dart';
import 'package:todo_app/view_model/firestore_utils.dart';

class TodoViewModel {
  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => AddTodoTaskWidget(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  static void showSelectedDate(
    BuildContext context,
    TextEditingController dateController,
    DateTime selectedDate,
  ) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    ).then((DateTime? value) {
      if (value != null) {
        dateController.text = DateFormat().add_yMMMd().format(value);
        selectedDate = value;
      }
      return;
    }).catchError((error) {
      print(error.toString());
    });
  }

  static void showSelectTime(
    BuildContext context,
    TextEditingController timeController,
    TimeOfDay selectedTime,
  ) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      timeController.text = value!.format(context).toString();
      selectedTime = value;
    });
  }

  static void addtodo(
    BuildContext context,
    GlobalKey<FormState> formKey,
    String title,
    String description,
    date,
    String time,
  ) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    FirestroeUtils.addTodoToFirestore(title, description, date, time)
        .then((value) {
      Navigator.pop(context);
      //show dialog task added successfully
      showToast(message: 'Task Added Sucessfully', state: ToastState.SUCCESS);
    }).onError((error, stackTrace) {
      print('${error.toString()} => error adding todo task');
      //show dialog can't adding task
      showToast(message: 'Can\'t Adding New Task', state: ToastState.ERROR);
    }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        // show dialog can't connect to server
      },
    );
  }

  static void showToast({
    required String message,
    required ToastState state,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        textColor: Colors.white,
        fontSize: 18,
        backgroundColor: chooseToastColor(state));
  }

  static Color chooseToastColor(ToastState state) {
    Color color;

    switch (state) {
      case ToastState.SUCCESS:
        color = Colors.green.shade700;
        break;
      case ToastState.ERROR:
        color = Colors.red.shade700;
        break;
    }
    return color;
  }
}

enum ToastState { SUCCESS, ERROR }
