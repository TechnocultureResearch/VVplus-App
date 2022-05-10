import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/branch_to_branch_receive_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Branch%20to%20Branch%20Receive/branch_to_branch_receive_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class BranchtoBranchReceivePage extends StatefulWidget{
  const BranchtoBranchReceivePage({Key key}) : super(key: key);

  @override
  _BranchtoBranchReceivePageState createState() => _BranchtoBranchReceivePageState();
}

class _BranchtoBranchReceivePageState extends State<BranchtoBranchReceivePage> {
  @override
  Widget build(BuildContext context) {
    return BranchToBranchReceiveProvider(
      child: Scaffold(
        appBar: appBarSatff("Branch to Branch Receive"),
        body: const BranchtoBranchReceiveBody(),
        bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );
  }
}

