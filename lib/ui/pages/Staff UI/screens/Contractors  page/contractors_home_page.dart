import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/Contractors%20%20page/contractors_home_page_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class ContractorsPage extends StatefulWidget{
  const ContractorsPage({Key key}) : super(key: key);

  @override
  _ContractorsPageState createState() => _ContractorsPageState();
}

class _ContractorsPageState extends State<ContractorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSatff("Contractors"),
      body: const ContractorsBody(),
      bottomNavigationBar: const BottomNavBarStaff(),
    );
  }
}

