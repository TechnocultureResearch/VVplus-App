import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Store_Page_Bloc/branch_to_branch_receive_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/store%20page/Branch%20to%20Branch%20Send/branch_to_branch_send_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class BranchtoBranchSendPage extends StatefulWidget{
  const BranchtoBranchSendPage({Key key}) : super(key: key);

  @override
  _BranchtoBranchSendPageState createState() => _BranchtoBranchSendPageState();
}

class _BranchtoBranchSendPageState extends State<BranchtoBranchSendPage> {
  @override
  Widget build(BuildContext context) {
    return BranchToBranchReceiveProvider(
      child: Scaffold(
        appBar: appBarSatff("Branch to Branch Send"),
        body: const BranchtoBranchSendBody(),
        // bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );
  }
}

