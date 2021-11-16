import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          color: const Color.fromRGBO(93, 156, 236, 1),
          height: size.height / 10,
        ),
      ],
    );
  }
}
