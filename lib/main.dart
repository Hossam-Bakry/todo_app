import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: MyThemeData.lightTheme,
      routes: {
        HomeScreen.routeName: (BuildContext contetx) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
