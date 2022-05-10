import 'package:flutter/material.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/goods_receipt_entry_page_bloc.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/Goods_Receipt_Entry/goods_receipt_entry_body.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/appbar_staff.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_bottomnavbar.dart';

class GoodsRecepitEntryPage extends StatefulWidget{
  const GoodsRecepitEntryPage({Key key}) : super(key: key);

  @override
  _GoodsRecepitEntryPageState createState() => _GoodsRecepitEntryPageState();
}

class _GoodsRecepitEntryPageState extends State<GoodsRecepitEntryPage> {
  @override
  Widget build(BuildContext context) {
    return GoodsReceiptEntryProvider(
      child: Scaffold(
        appBar: appBarSatff("Goods Recepit Entry"),
        body: const GoodsRecepitEntryBody(),
        // bottomNavigationBar: const BottomNavBarStaff(),
      ),
    );
  }
}