import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/purchase_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key key}) : super(key: key);

  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarSatff("Purchase"),
        body: const PurchaseBody(),
        bottomNavigationBar: BottomNavBarStaff());
  }
}
