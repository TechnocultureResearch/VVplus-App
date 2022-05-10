import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/extra_work_entry_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/Extra%20Work%20Entry/extra_work_entry_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class ExtraWorkEntryPage extends StatelessWidget{
  const ExtraWorkEntryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalesExtraWorkEntryProvider(
      child: Scaffold(
        appBar: appBarSatff("Extra Work Entry"),
        body: const ExtraWorkEntryBody(),
        // bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );

  }

}