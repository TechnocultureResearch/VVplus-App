import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'dart:math'as math;

AppBar AppBarSatff(String appBarText) {
  return AppBar(
    centerTitle: true,
    toolbarHeight: 100,
    title: Text(
      appBarText,
      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Container(
        child: Padding(
          padding: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),

        ),
      ),
    ],
    titleTextStyle: const TextStyle(color: PrimaryColor3),
    backgroundColor: PrimaryColor1,
  );
}
