// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vvplus_app/NavBarTest/ProfileStaff.dart';
import 'package:vvplus_app/NavBarTest/staff_Navigation.dart';

import 'package:vvplus_app/ui/pages/Staff%20UI/screens/home%20page/staff_homepage.dart';
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
            builder: (context) => ProfileStaff(),
          ));
    }

    setState(() {
      _pastIndex = _selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //NavigationBar
      backgroundColor: primaryColor3,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      elevation: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: primaryColor2,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 32,
              color: primaryColor2,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 32,
              color: primaryColor2,
            ),
            activeIcon: Icon(
              Icons.notifications,
              size: 32,
              color: primaryColor4,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.check,
              size: 32,
              color: primaryColor2,
            ),
            activeIcon: Icon(
              Icons.check,
              size: 32,
              color: primaryColor4,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 32,
              color: primaryColor2,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              size: 32,
              color: primaryColor4,
            ),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      // onTap: (index) {
      //   if (index == 0) {
      //     BlocProvider.of<NavigationCubit>(context)
      //         .getNavBarItem(NavbarItem.home);
      //   } else if (index == 1) {
      //     BlocProvider.of<NavigationCubit>(context)
      //         .getNavBarItem(NavbarItem.settings);
      //   } else if (index == 2) {
      //     BlocProvider.of<NavigationCubit>(context)
      //         .getNavBarItem(NavbarItem.profile);
      //   }
      // },
      // ),
    );
  }
}
