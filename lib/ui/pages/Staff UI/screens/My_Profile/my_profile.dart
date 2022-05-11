import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/My_Profile/attendance_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/My_Profile/file_incentive.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/My_Profile/leave_application.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/My_Profile/request_advance.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';
import 'attendance_page.dart';


//   String name = 'User Name';

bool _flutter = false;


class MyProfileBody extends StatefulWidget {
  const MyProfileBody({Key key}) : super(key: key);

  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarSatff("My Profile"),
        body:
        ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor1, Colors.lightGreen],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.4, 0.8],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                          NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'User Name',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Civil Engineer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    child: SwitchListTile(
                      title: const Text(text70,style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                          fontSize: 20
                      ),
                      ),
                      value: _flutter,
                      activeColor: Colors.red,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (bool value) {
                        setState(() {
                          _flutter = value;
                        });
                      },
                    ),
                  ),
                  // ListTile(
                  //   onTap: (){ Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => AttendancePage(),
                  //       ));
                  //     },
                  //   title: Text(
                  //     text70,
                  //     style: TextStyle(
                  //       color: Colors.deepOrange,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   subtitle: Text(
                  //     text71,
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //     ),
                  //   ),
                  // ),
                  Divider(),
                  ListTile(
                    onTap: (){ Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestAdvance(),
                        ));
                    },
                    title: const Text(
                      text72,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      text73,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FileIncentive(),
                          ));
                    },
                    title: Text(
                      text74,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      text75,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),Divider(),
                  ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LeaveApplication(),
                          ));
                    },
                    title: Text(
                      text76,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      text77,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
