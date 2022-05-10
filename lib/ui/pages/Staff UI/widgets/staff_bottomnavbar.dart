// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vvplus_app/NavBarTest/staff_Navigation.dart';

import 'package:vvplus_app/ui/pages/Staff%20UI/screens/home%20page/staff_homepage.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/my_profile.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

class BottomNavBarStaff extends StatefulWidget {
  const BottomNavBarStaff({Key key}) : super(key: key);

  @override
  State<BottomNavBarStaff> createState() => _MyBottomNavbarStaff();
}

class _MyBottomNavbarStaff extends State<BottomNavBarStaff> {
  int _selectedIndex = 0;
  int _pastIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageStaff(),
          ));
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationStaff(),
          ));
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationStaff(),
          ));
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyProfileBody(),
          ));
    }
    //  else {
    //   if(_selectedIndex != _pastIndex){
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => _screens[_selectedIndex],
    //         ));
    //   }
    //
    // }
    setState(() {
      _pastIndex = _selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //NavigationBar
      backgroundColor: primaryColor1,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      elevation: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: primaryColor3,
            ),
            activeIcon: Icon(
              Icons.home,
              color: primaryColor5,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: primaryColor3,
            ),
            activeIcon: Icon(
              Icons.notifications,
              color: primaryColor5,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.check,
              size: 30,
              color: primaryColor3,
            ),
            activeIcon: Icon(
              Icons.check,
              size: 30,
              color: primaryColor5,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: primaryColor3,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: primaryColor5,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
