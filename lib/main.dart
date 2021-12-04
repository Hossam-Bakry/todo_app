import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'package:todo_app/view/layout/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider()..todoItems(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  late AppProvider provider;
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    sharedPrefrence();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.appThemeMode,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      routes: {
        HomeScreen.routeName: (BuildContext contetx) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }

  void sharedPrefrence() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString('theme') == 'light') {
      provider.changeThemeMode(ThemeMode.light);
    } else if (prefs.getString('theme') == 'dark') {
      provider.changeThemeMode(ThemeMode.dark);
    }
  }
}
