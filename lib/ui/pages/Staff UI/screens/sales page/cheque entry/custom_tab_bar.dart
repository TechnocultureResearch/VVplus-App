import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: width * .9,
        height: height * .08,
        // width: 343,
        // height: 53,
        color: primaryColor8,
        child: TabBar(
          tabs: const [
            Tab(
              text: 'Receive',
            ),
            Tab(text: 'Deposit'),
            Tab(text: 'Cleared'),
          ],
          labelPadding: const EdgeInsets.symmetric(vertical: 4),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: primaryColor8),
            color: primaryColor3,
          ),
          labelColor: primaryColor1,
          unselectedLabelColor: primaryColor9,
          labelStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
