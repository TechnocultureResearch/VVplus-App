// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/home%20page/staff_homepage_body.dart';


class BottomNavBarStaff extends StatefulWidget {
  const BottomNavBarStaff({Key key}) : super(key: key);

  @override
  State<BottomNavBarStaff> createState() => _MyBottomNavbarStaff();
}
class _MyBottomNavbarStaff extends State<BottomNavBarStaff>{
  int _selectedIndex = 0;
  int activeIndex = 0;
  void changeActivePage(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  static  List<Widget> pages = [];
  @override
  void initState() {
    pages = [

      HomeBody(),
      HomeBody(),
      HomeBody(), HomeBody()
    ];
    super.initState();
  }

  // final pagess = [const HomeBody(),
  //   MyProfileBody(), const HomeBody(), MyProfileBody()];
  // PersistentTabController _controller;



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  // List<Widget> _buildScreens() {
  //   return [
  //     HomeBody(),MyProfileBody(),HomeBody(),MyProfileBody()
  //   ];
  // }
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //   PersistentBottomNavBarItem(
  //       icon: Icon(Icons.home,color: primaryColor3,),
  //       // activeIcon: Icon(Icons.home,color: primaryColor5,),
  //
  //       // title: Text('', style: TextStyle(color: primaryColor2))
  //   ),
  //     PersistentBottomNavBarItem(
  //         icon: Icon(Icons.notifications,color: primaryColor3,),
  //     // inactiveIcon: Icon(Icons.home,color: primaryColor5,),
  //
  //
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.check,color: primaryColor3,),
  //       // inactiveIcon: Icon(Icons.home,color: primaryColor5,),
  //
  //     ),
  //
  //     PersistentBottomNavBarItem(
  //       icon: Icon(Icons.account_circle,color: primaryColor3,),
  //       // inactiveIcon: Icon(Icons.home,color: primaryColor5,),
  //
  //     ),
  //
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () => changeActivePage(0), icon: Icon(Icons.home),iconSize: 29,),
              IconButton(onPressed: () => changeActivePage(1), icon: Icon(Icons.notifications),iconSize: 29,),
              IconButton(onPressed: () => changeActivePage(2), icon: Icon(Icons.check),iconSize: 29,),
              IconButton(onPressed: () => changeActivePage(3), icon: Icon(Icons.account_circle),iconSize: 29,),
            ],
          ),
        ),
        body: pages[activeIndex]);
 // return BottomNavigationBar(
 //      backgroundColor: primaryColor1,
 //      type: BottomNavigationBarType.fixed,
 //      showUnselectedLabels: true,
 //      elevation: 10,
 //      items: const <BottomNavigationBarItem>[
 //        BottomNavigationBarItem(
 //            icon: Icon(Icons.home,color: primaryColor3,),
 //            activeIcon: Icon(Icons.home,color: primaryColor5,),
 //            // title: Text('', style: TextStyle(color: primaryColor2))
 //            label: ''
 //        ),
 //        BottomNavigationBarItem(
 //            icon: Icon(Icons.notifications,color: primaryColor3,),
 //            activeIcon: Icon(Icons.notifications,color: primaryColor5,),
 //            // title: Text('', style: TextStyle(color: primaryColor2))
 //            label: ''
 //        ),
 //        BottomNavigationBarItem(
 //            icon: Icon(Icons.check,size: 30,color: primaryColor3,),
 //            activeIcon: Icon(Icons.check,size:30,color: primaryColor5,),
 //            // title: Text('', style: TextStyle(color: primaryColor2))
 //            label: ''
 //        ),
 //        BottomNavigationBarItem(
 //            icon: Icon(Icons.account_circle,color: primaryColor3,),
 //            activeIcon: Icon(Icons.account_circle,color: primaryColor5,),
 //            // title: Text('', style: TextStyle(color: primaryColor2))
 //            label: ''
 //        ),
 //      ],
 //      currentIndex: _selectedIndex,
 //      selectedItemColor: Colors.grey,
 //      onTap: _onItemTapped,
 //    );
  }
}



