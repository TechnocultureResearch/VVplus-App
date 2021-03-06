import 'package:flutter/material.dart';
import 'package:vvplus_app/constants/colors.dart';

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
            backgroundColor: PrimaryColor3,
            icon: Icon(Icons.circle),
            title: Text('', style: TextStyle(color: PrimaryColor2))),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            title: Text('', style: TextStyle(color: PrimaryColor2))),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            title: Text('', style: TextStyle(color: Colors.black))),
        BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            title: Text('', style: TextStyle(color: PrimaryColor2))),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      onTap: _onItemTapped,
    );
  }
  }



