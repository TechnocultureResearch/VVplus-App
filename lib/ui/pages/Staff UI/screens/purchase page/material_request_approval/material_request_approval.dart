import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/material_request_approval/material_request_approval_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class MaterialRequestApproval extends StatefulWidget{
  const MaterialRequestApproval({Key key}) : super(key: key);

  @override
  _MaterialRequestApprovalState createState() => _MaterialRequestApprovalState();
}

class _MaterialRequestApprovalState extends State<MaterialRequestApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSatff("Material Req. Approval"),
      body: const MaterialRequestApprovalBody(),
      bottomNavigationBar: const BottomNavBarStaff(),
    );
  }
}

