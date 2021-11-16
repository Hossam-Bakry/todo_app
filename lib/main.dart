import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'package:todo_app/view/layout/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      routes: {
        HomeScreen.routeName: (BuildContext contetx) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
