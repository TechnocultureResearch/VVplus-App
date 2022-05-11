import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

import '../ui/pages/Staff UI/screens/My_Profile/my_profile.dart';

class ProfileStaff extends StatefulWidget {
  @override
  _ProfileStaffState createState() => _ProfileStaffState();
}

class _ProfileStaffState extends State<ProfileStaff> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyProfileBody(),
      bottomNavigationBar: BottomNavBarStaff(),
    );
  }
}
