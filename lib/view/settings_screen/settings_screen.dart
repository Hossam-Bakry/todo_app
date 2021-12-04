import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/provider/app_provider.dart';
import 'package:todo_app/shared/styles/themes.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? valueSelectetd;

  String? themeValue;

  List<String> languageList = ['English', 'العربية'];

  List<String> ThemeModeList = ['Dark', 'Light'];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          color: const Color.fromRGBO(93, 156, 236, 1),
          height: size.height / 10,
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.all(30),
          child: const Text(
            'Language',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: MyThemeData.primaryColor,
            ),
            color: Colors.white,
          ),
          child: DropdownButton(
            style: const TextStyle(
              fontSize: 14,
              color: MyThemeData.primaryColor,
            ),
            underline: const SizedBox(),
            iconSize: 28.0,
            iconEnabledColor: MyThemeData.primaryColor,
            alignment: Alignment.bottomCenter,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'English',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: MyThemeData.primaryColor,
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(20.0),
            isExpanded: true,
            items: languageList
                .map(
                  (value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ),
                )
                .toList(),
            onChanged: (String? newValue) {
              valueSelectetd = newValue;
              if (valueSelectetd == 'English') {
              } else {}
            },
            value: valueSelectetd,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.all(30),
          child: const Text(
            'Theme Mode',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: MyThemeData.primaryColor,
            ),
            color: Colors.white,
          ),
          child: DropdownButton(
            style: const TextStyle(
              fontSize: 14,
              color: MyThemeData.primaryColor,
            ),
            underline: const SizedBox(),
            iconSize: 28.0,
            iconEnabledColor: MyThemeData.primaryColor,
            alignment: Alignment.bottomCenter,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  provider.appThemeMode == ThemeMode.dark ? 'Dark' : 'Light',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyThemeData.primaryColor,
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.circular(20.0),
            isExpanded: true,
            items: ThemeModeList.map(
              (value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ),
            ).toList(),
            onChanged: (String? newValue) {
              themeValue = newValue;
              setState(() {
                themeValue == 'Dark'
                    ? provider.changeThemeMode(ThemeMode.dark)
                    : provider.changeThemeMode(ThemeMode.light);
              });
            },
            value: themeValue,
          ),
        ),
      ],
    );
  }
}
