// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _MyBottomNavbar();
}
class _MyBottomNavbar extends State<BottomNavBar>{
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      //NavigationBar
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      elevation: 10,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            backgroundColor: primaryColor3,
            icon: Icon(Icons.circle),
            // title: Text('', style: TextStyle(color: primaryColor2))
          label: ''
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            // title: Text('', style: TextStyle(color: Colors.black))
            label: ''
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            // title: Text('', style: TextStyle(color: primaryColor2))
            label: ''
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      onTap: _onItemTapped,
    );
  }
  }



