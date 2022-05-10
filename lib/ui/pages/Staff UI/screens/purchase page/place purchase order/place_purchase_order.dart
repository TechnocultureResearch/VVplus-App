import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/place_purchase_order_page_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/place%20purchase%20order/place_purchase_order_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class PlacePurchaseOrder extends StatefulWidget{
  const PlacePurchaseOrder({Key key}) : super(key: key);

  @override
  _PlacePurchaseOrderState createState() => _PlacePurchaseOrderState();
}

class _PlacePurchaseOrderState extends State<PlacePurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return PlacePurchaseOrderProvider(
      child: Scaffold(
        appBar: appBarSatff("Place Purchase Order"),
        body: const PlacePurchaseOrderBody(),
        bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );
  }
}

