import 'package:flutter/material.dart';
import 'package:vvplus_app/NavBarTest/Navigation_Page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class NotificationStaff extends StatefulWidget {
  @override
  _NotificationStaffState createState() => _NotificationStaffState();
}

class _NotificationStaffState extends State<NotificationStaff> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationPage(),
      bottomNavigationBar: BottomNavBarStaff(),
    );
  }
}
