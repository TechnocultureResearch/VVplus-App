import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Sales_page_bloc/cheque_entry_update_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/cheque%20entry/cheque_entry_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class ChequeEntry extends StatefulWidget{
  const ChequeEntry({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState()=> MyChequeEntry();
}

class MyChequeEntry extends State<ChequeEntry> {
  @override
  Widget build(BuildContext context) {
    return ChequeEntryUpdateProvider(
      child: Scaffold(
        appBar: appBarSatff("Cheque Entry/Update"),
        body: const ChequeEntryBody(),
        bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );
  }
}