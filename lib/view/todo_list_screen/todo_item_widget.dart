import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/shared/network/remote/firestore_utils.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'package:todo_app/view/todo_list_screen/todo_details.dart';
import 'package:todo_app/view_model/todo_screen_view_model.dart';

class TodoItem extends StatelessWidget {
  Todo item;

  TodoItem(this.item);

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext contetx) => TodoDetails(item),
          ),
          // arguments: TodoArg(item),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 15.0,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 120,
        child: Slidable(
          actionPane: const SlidableBehindActionPane(),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  width: 5.0,
                  decoration: BoxDecoration(
                    color: item.isDone
                        ? MyThemeData.doneColor
                        : MyThemeData.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: item.isDone
                              ? MyThemeData.doneColor
                              : MyThemeData.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Icon(Icons.schedule),
                          const SizedBox(width: 10),
                          Text(
                            item.time,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      FirestroeUtils.doneTask(item);
                      provider.todoItems();
                    },
                    child: item.isDone
                        ? const Text(
                            'Done!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: MyThemeData.doneColor,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            width: 70.0,
                            height: 35.0,
                            decoration: const BoxDecoration(
                              color: MyThemeData.primaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Image.asset('assets/images/ic_check.png'),
                          ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconSlideAction(
              onTap: () {
                FirestroeUtils.deleteTask(item)
                    .onError((error, stackTrace) {})
                    .then((value) {
                  TodoViewModel.showToast(
                    message: 'Item Deleted Successfully',
                    state: ToastState.WARNING,
                  );
                }).timeout(const Duration(seconds: 30), onTimeout: () {});
              },
              color: Colors.transparent,
              iconWidget: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete,
                      size: 45,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Delete',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
