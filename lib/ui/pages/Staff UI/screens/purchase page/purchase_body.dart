import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/Goods_Receipt_Entry/goods_receipt_entry_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/Material_request_entry/material_request_entry_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/place%20purchase%20order/place_purchase_order.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';
import 'material_request_approval/material_request_approval.dart';

class PurchaseBody extends StatelessWidget{
  final Widget child;

  const PurchaseBody({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Padding(
          padding: paddingForms3,
          child: Container(
          alignment: Alignment.center,
          height: 130,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: primaryColor3,
            boxShadow: const [
              BoxShadow(
                color: primaryColor5,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      "Notification",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
      ],
    ),
          ),
        ),
          sizedbox1,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              roundedButtonHome(text38, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MaterialReqEntry()));
              }),

              roundedButtonHome(text39, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MaterialRequestApproval()));
              }),
              roundedButtonHome(text40, () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PlacePurchaseOrder()));}),
              roundedButtonHome(text41, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GoodsRecepitEntryPage()));
              }),
            ],
          ),
        ],
      ),
    );
  }

}