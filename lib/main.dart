import 'package:flutter/material.dart';
import 'package:vvplus_app/components/colors.dart';
import 'package:vvplus_app/screens/Login%20page/login_page.dart';
import 'package:vvplus_app/screens/NewComplaint%20page/new_complaint_page.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: PrimaryColor1,
          scaffoldBackgroundColor: PrimaryColor3),
      home: ComplaintPage(),
    );
  }
}

