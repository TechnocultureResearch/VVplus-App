import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';

class FileIncentive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSatff("File incentive"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 10),
        child: Text(
          'First Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}