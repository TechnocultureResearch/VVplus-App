import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/discount_approval_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/Discount%20Approval%20page/discount_approval_home_page_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class DiscountApprovalPage extends StatelessWidget{
  const DiscountApprovalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DiscountApprovalProvider(
      child: Scaffold(
        appBar: appBarSatff("Discount Approval"),
        body: const DiscountApprovalBody(),
        bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );

  }

}