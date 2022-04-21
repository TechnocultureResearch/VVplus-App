import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

AppBar appBarSatff(String appBarText) {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 60,
    title: Text(
      appBarText,
      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),

      ),
    ],
    titleTextStyle: const TextStyle(color: primaryColor3),
    backgroundColor: primaryColor1,
  );
}
