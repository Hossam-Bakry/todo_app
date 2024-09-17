import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/view/settings_screen/settings_screen.dart';
import 'package:todo_app/view/todo_list_screen/todo_list_screen.dart';
import 'package:todo_app/view_model/todo_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    TodoListScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        leading: const SizedBox(),
        title: Text(
          currentIndex == 0 ? 'To Do List' : 'Settings',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: provider.appThemeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TodoViewModel.showAddTaskSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 8.0,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/ic_menu.png')),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/ic-setting.png')),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
