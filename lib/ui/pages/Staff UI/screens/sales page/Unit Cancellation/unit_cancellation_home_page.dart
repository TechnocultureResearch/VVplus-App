import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/unit_cancellation_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/Unit%20Cancellation/unit_cancellation_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class UnitCancellationPage extends StatelessWidget{
  const UnitCancellationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnitCancellationProvider(
      child: Scaffold(
        appBar: appBarSatff("Unit Cancellation"),
        body: const UnitCancellationBody(),
        // bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );

  }

}