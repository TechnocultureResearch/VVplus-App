import 'package:flutter/material.dart';

Padding FormsHeadText(String text){
  return Padding(
    padding:EdgeInsets.symmetric(horizontal:40),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
    ),
  );

}