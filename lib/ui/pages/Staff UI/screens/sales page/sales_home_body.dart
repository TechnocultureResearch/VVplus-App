import 'package:flutter/material.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/Discount%20Approval%20page/discount_approval_home_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/Extra%20Work%20Entry/extra_work_entry_home.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/Unit%20Cancellation/unit_cancellation_home_page.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/sales%20page/cheque%20entry/cheque_entry.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';

class SalesBody extends StatelessWidget {
  final Widget child;

  const SalesBody({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 45, right: 45),
            child: Container(
              alignment: Alignment.center,
              height: height * .2,
              // width: 300,
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: 14)),
              roundedButtonHome(text47, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExtraWorkEntryPage()));
              }),
              roundedButtonHome(text48, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UnitCancellationPage()));
              }),
              roundedButtonHome(text49, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChequeEntry()));
              }),
              roundedButtonHome(text50, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiscountApprovalPage()));
              }),
            ],
          ),
        ],
      ),
    );
  }
}
